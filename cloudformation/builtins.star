PARAMETER_TYPE_STRING = "String"
PARAMETER_TYPE_NUMBER = "Number"
PARAMETER_TYPE_LIST_NUMBER = "List<Number>"
PARAMETER_TYPE_COMMA_DELIMITED_LIST = "CommaDelimitedList"

def Resource(type, properties = None, depends_on = None):
    out = {"Type": type}
    if depends_on != None:
        out["DependsOn"] = depends_on
    if properties != None:
        out["Properties"] = properties
    return out

def Ref(target):
    return {"Ref": target}

def GetAtt(target):
    return {"Fn::GetAtt": target}

def Base64(data):
    return {"Fn::Base64": data}

def Join(sep, parts):
    return {"Fn::Join": [sep, parts]}

def Sub(data):
    return {"Fn::Sub": data}

def Output(value, description = None):
    out = {}
    if description != None:
        out["Description"] = description
    out["Value"] = value
    return out

def Parameter(
        type_,
        description = None,
        default = None,
        allowed_pattern = None,
        allowed_values = None,
        constraint_description = None,
        max_length = None,
        max_value = None,
        min_length = None,
        min_value = None,
        no_echo = None):
    properties = {"Type": type_}
    if description != None:
        properties["Description"] = description
    if default != None:
        properties["Default"] = default
    if allowed_pattern != None:
        properties["AllowedPattern"] = allowed_pattern
    if allowed_values != None:
        properties["AllowedValues"] = allowed_values
    if constraint_description != None:
        properties["ConstraintDescription"] = constraint_description
    if max_length != None:
        properties["MaxLength"] = max_length
    if max_value != None:
        properties["MaxValue"] = max_value
    if min_length != None:
        properties["MinLength"] = min_length
    if min_value != None:
        properties["MinValue"] = min_value
    if no_echo != None:
        properties["NoEcho"] = no_echo
    return properties

def Template(
        description = None,
        parameters = None,
        resources = None,
        outputs = None,
        version = "2010-09-09"):
    out = {"AWSTemplateFormatVersion": version}
    if description != None:
        out["Description"] = description
    if parameters != None:
        out["Parameters"] = parameters
    if resources != None:
        out["Resources"] = resources
    if outputs != None:
        out["Outputs"] = outputs
    return out
