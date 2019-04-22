load("cloudformation/builtins", "Resource")

def Cluster(name, role_arn, resources_vpc_config, version=None):
    properties = {
        "Name": name,
        "RoleArn": role_arn,
        "ResourcesVpcConfig": resources_vpc_config,
    }
    if version != None:
        properties["Version"] = version
    return Resource(type="AWS::EKS::Cluster", properties=properties)