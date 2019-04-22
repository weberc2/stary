load("cloudformation/builtins", "Resource")

POLICY_AMAZON_ECS_TASK_EXECUTION_ROLE = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

def InstanceProfile(path, roles = None):
    properties = {"Path": path}
    if roles != None:
        properties["Roles"] = roles
    return Resource(type = "AWS::IAM::InstanceProfile", properties = properties)

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-policy.html
def PolicyProperties(policy_name, policy_document):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-policy.html"""
    return {
        "PolicyName": policy_name,
        "PolicyDocument": policy_document,
    }

def Role(
        assume_role_policy_document,
        path,
        role_name = None,
        managed_policy_arns = None,
        policies = None):
    properties = {}
    if role_name != None:
        properties["RoleName"] = role_name
    properties["AssumeRolePolicyDocument"] = assume_role_policy_document
    properties["Path"] = path
    if managed_policy_arns != None:
        properties["ManagedPolicyArns"] = managed_policy_arns
    if policies != None:
        properties["Policies"] = policies
    return Resource(type = "AWS::IAM::Role", properties = properties)
