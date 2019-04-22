package main

import (
	"encoding/binary"
	"fmt"
	"hash/adler32"
	"io"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"

	"github.com/pkg/errors"
	sl "go.starlark.net/starlark"
	yaml "gopkg.in/yaml.v2"
)

type StructField struct {
	Name  string
	Value sl.Value
}

type Struct []StructField

func (s Struct) MarshalYAML() (interface{}, error) {
	out := make(yaml.MapSlice, len(s))
	for i, field := range s {
		valueYAML, err := slYAML(field.Value)
		if err != nil {
			return nil, err
		}
		out[i] = yaml.MapItem{Key: field.Name, Value: valueYAML}
	}
	return out, nil
}

func (s Struct) Attr(name string) (sl.Value, error) {
	for _, field := range s {
		if field.Name == name {
			return field.Value, nil
		}
	}
	// per the sl.HasAttrs docs, return (nil, nil) for "attr not found"
	return nil, nil
}

func (s Struct) AttrNames() []string {
	names := make([]string, len(s))
	for i, field := range s {
		names[i] = field.Name
	}
	return names
}

func (s Struct) Type() string {
	return fmt.Sprintf("struct{%s}", strings.Join(s.AttrNames(), ", "))
}

func (s Struct) String() string {
	fields := make([]string, len(s))
	for i, field := range s {
		fields[i] = fmt.Sprintf("%s=%s", field.Name, field.Value)
	}
	return fmt.Sprintf("struct{%s}", strings.Join(fields, ", "))
}

func (s Struct) Freeze() {}

func (s Struct) Truth() sl.Bool { return sl.True }

func (s Struct) Hash() (uint32, error) {
	// Each field corresponds to 8 bytes (4 bytes for the field name hash and
	// another 4 bytes for the field value hash). 4 bytes because that's how
	// many bytes are in one uint32.
	const hashesPerField = 2 // 2 hashes per field (name hash and value hash)
	const bytesPerHash = 4   // 4 bytes per hash; 1 hash is a uint32
	const bytesPerField = bytesPerHash * hashesPerField
	buf := make([]byte, bytesPerField*len(s))
	for i, field := range s {
		nameHashStart := i * bytesPerField
		valueHashStart := nameHashStart + bytesPerHash
		valueHashEnd := valueHashStart + bytesPerHash
		binary.BigEndian.PutUint32(
			buf[nameHashStart:valueHashStart],
			adler32.Checksum([]byte(field.Name)),
		)
		h, err := field.Value.Hash()
		if err != nil {
			return 0, err
		}
		binary.BigEndian.PutUint32(buf[valueHashStart:valueHashEnd], h)
	}
	return adler32.Checksum(buf), nil
}

func slYAML(v sl.Value) (interface{}, error) {
	switch x := v.(type) {
	case *sl.Dict:
		m := make(yaml.MapSlice, x.Len())
		for i, key := range x.Keys() {
			if s, ok := sl.AsString(key); ok {
				v, _, _ := x.Get(key)
				iface, err := slYAML(v)
				if err != nil {
					return nil, errors.Wrapf(err, "In dict at key '%s':", s)
				}
				m[i] = yaml.MapItem{Key: s, Value: iface}
				continue
			}
			return nil, errors.Errorf(
				"TypeError: wanted dict key type 'str'; got '%s'",
				key.Type(),
			)
		}
		return m, nil
	case *sl.List:
		slice := make([]interface{}, x.Len())
		for i := range slice {
			v, err := slYAML(x.Index(i))
			if err != nil {
				return nil, err
			}
			slice[i] = v
		}
		return slice, nil
	case sl.Float:
		return float64(x), nil
	case sl.Int:
		return x.Float(), nil
	default:
		return x, nil
	}
}

type loadFunc func(loadFunc, string) (sl.StringDict, error)

func slLoadFunc(lf loadFunc) func(*sl.Thread, string) (sl.StringDict, error) {
	return func(_ *sl.Thread, mod string) (sl.StringDict, error) {
		return lf(lf, mod)
	}
}

func cachingDecorator(load loadFunc) loadFunc {
	type entry struct {
		globals sl.StringDict
		err     error
	}
	entrycache := make(map[string]*entry)

	var decorator func(loadFunc) loadFunc
	decorator = func(loadFunc) loadFunc {
		return func(self loadFunc, mod string) (sl.StringDict, error) {
			e, ok := entrycache[mod]
			if e == nil {
				if ok {
					// request for module whose loading is in progress
					return nil, errors.Errorf("Cycle in load graph")
				}

				// Add a placeholder to indicate "load in progress"
				entrycache[mod] = nil

				// Load and initialize the module
				globals, err := load(decorator(load), mod)
				e = &entry{globals, err}
				entrycache[mod] = e
			}
			return e.globals, e.err
		}
	}

	return decorator(load)
}

func filePathLoadFunc(
	builtins sl.StringDict,
	resolve func(string) (string, error),
) loadFunc {
	return func(self loadFunc, mod string) (sl.StringDict, error) {
		path, err := resolve(mod)
		if err != nil {
			return nil, err
		}

		data, err := ioutil.ReadFile(path)
		if err != nil {
			return nil, err
		}

		// Run the file in its own thread
		return sl.ExecFile(
			&sl.Thread{
				Name:  mod,
				Print: nil,
				Load:  slLoadFunc(self),
			},
			path,
			data,
			builtins,
		)
	}
}

func writeYAML(w io.Writer, v interface{}) error {
	data, err := yaml.Marshal(v)
	if err != nil {
		return err
	}

	_, err = w.Write(data)
	return err
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintf(
			os.Stderr,
			"USAGE: %s <entrypoint.star>\n",
			filepath.Base(os.Args[0]),
		)
		os.Exit(1)
	}
	entryPointFile := os.Args[1]
	entryPointModule := entryPointFile[:len(entryPointFile)-len(filepath.Ext(entryPointFile))]

	wd, err := os.Getwd()
	if err != nil {
		panic(err)
	}

	load := slLoadFunc(cachingDecorator(filePathLoadFunc(
		sl.StringDict{
			"struct": sl.NewBuiltin(
				"struct",
				func(
					_ *sl.Thread,
					_ *sl.Builtin,
					args sl.Tuple,
					kwargs []sl.Tuple,
				) (sl.Value, error) {
					if len(args) > 0 {
						return nil, fmt.Errorf("struct() only accepts kwargs")
					}
					s := make(Struct, len(kwargs))
					for i, kwarg := range kwargs {
						if len(kwarg) < 2 {
							panic("kwarg is missing a key or value or both")
						}
						name, ok := sl.AsString(kwarg[0])
						if !ok {
							panic("key in kwarg is not a string")
						}
						s[i].Name = string(name)
						s[i].Value = kwarg[1]
					}
					return s, nil
				},
			),
		},
		func(mod string) (string, error) {
			return filepath.Join(wd, mod+".star"), nil
		},
	)))

	globals, err := load(&sl.Thread{}, entryPointModule)
	if err != nil {
		if err, ok := err.(*sl.EvalError); ok {
			log.Fatal(err.Backtrace())
		}
		log.Fatal(err)
	}

	if yamlable, found := globals["__yaml__"]; found {
		y, err := slYAML(yamlable)
		if err != nil {
			log.Fatal(err)
		}

		if err := writeYAML(os.Stdout, y); err != nil {
			log.Fatal(err)
		}
		return
	}

	log.Fatal("Missing __yaml__ from %s", entryPointFile)
}
