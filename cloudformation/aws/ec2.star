load("cloudformation/builtins", "Resource")

INSTANCE_TYPE_T2_SMALL = "t2.small"
INSTANCE_TYPE_T2_MEDIUM = "t2.medium"
INSTANCE_TYPE_T2_LARGE = "t2.large"
INSTANCE_TYPE_T2_XLARGE = "t2.xlarge"
INSTANCE_TYPE_T2_2XLARGE = "t2.2xlarge"
INSTANCE_TYPE_T3_NANO = "t3.nano"
INSTANCE_TYPE_T3_MICRO = "t3.micro"
INSTANCE_TYPE_T3_SMALL = "t3.small"
INSTANCE_TYPE_T3_MEDIUM = "t3.medium"
INSTANCE_TYPE_T3_LARGE = "t3.large"
INSTANCE_TYPE_T3_XLARGE = "t3.xlarge"
INSTANCE_TYPE_T3_2XLARGE = "t3.2xlarge"
INSTANCE_TYPE_M3_MEDIUM = "m3.medium"
INSTANCE_TYPE_M3_LARGE = "m3.large"
INSTANCE_TYPE_M3_XLARGE = "m3.xlarge"
INSTANCE_TYPE_M3_2XLARGE = "m3.2xlarge"
INSTANCE_TYPE_M4_LARGE = "m4.large"
INSTANCE_TYPE_M4_XLARGE = "m4.xlarge"
INSTANCE_TYPE_M4_2XLARGE = "m4.2xlarge"
INSTANCE_TYPE_M4_4XLARGE = "m4.4xlarge"
INSTANCE_TYPE_M4_10XLARGE = "m4.10xlarge"
INSTANCE_TYPE_M5_LARGE = "m5.large"
INSTANCE_TYPE_M5_XLARGE = "m5.xlarge"
INSTANCE_TYPE_M5_2XLARGE = "m5.2xlarge"
INSTANCE_TYPE_M5_4XLARGE = "m5.4xlarge"
INSTANCE_TYPE_M5_12XLARGE = "m5.12xlarge"
INSTANCE_TYPE_M5_24XLARGE = "m5.24xlarge"
INSTANCE_TYPE_C4_LARGE = "c4.large"
INSTANCE_TYPE_C4_XLARGE = "c4.xlarge"
INSTANCE_TYPE_C4_2XLARGE = "c4.2xlarge"
INSTANCE_TYPE_C4_4XLARGE = "c4.4xlarge"
INSTANCE_TYPE_C4_8XLARGE = "c4.8xlarge"
INSTANCE_TYPE_C5_LARGE = "c5.large"
INSTANCE_TYPE_C5_XLARGE = "c5.xlarge"
INSTANCE_TYPE_C5_2XLARGE = "c5.2xlarge"
INSTANCE_TYPE_C5_4XLARGE = "c5.4xlarge"
INSTANCE_TYPE_C5_9XLARGE = "c5.9xlarge"
INSTANCE_TYPE_C5_18XLARGE = "c5.18xlarge"
INSTANCE_TYPE_I3_LARGE = "i3.large"
INSTANCE_TYPE_I3_XLARGE = "i3.xlarge"
INSTANCE_TYPE_I3_2XLARGE = "i3.2xlarge"
INSTANCE_TYPE_I3_4XLARGE = "i3.4xlarge"
INSTANCE_TYPE_I3_8XLARGE = "i3.8xlarge"
INSTANCE_TYPE_I3_16XLARGE = "i3.16xlarge"
INSTANCE_TYPE_R3_XLARGE = "r3.xlarge"
INSTANCE_TYPE_R3_2XLARGE = "r3.2xlarge"
INSTANCE_TYPE_R3_4XLARGE = "r3.4xlarge"
INSTANCE_TYPE_R3_8XLARGE = "r3.8xlarge"
INSTANCE_TYPE_R4_LARGE = "r4.large"
INSTANCE_TYPE_R4_XLARGE = "r4.xlarge"
INSTANCE_TYPE_R4_2XLARGE = "r4.2xlarge"
INSTANCE_TYPE_R4_4XLARGE = "r4.4xlarge"
INSTANCE_TYPE_R4_8XLARGE = "r4.8xlarge"
INSTANCE_TYPE_R4_16XLARGE = "r4.16xlarge"
INSTANCE_TYPE_X1_16XLARGE = "x1.16xlarge"
INSTANCE_TYPE_X1_32XLARGE = "x1.32xlarge"
INSTANCE_TYPE_P2_XLARGE = "p2.xlarge"
INSTANCE_TYPE_P2_8XLARGE = "p2.8xlarge"
INSTANCE_TYPE_P2_16XLARGE = "p2.16xlarge"
INSTANCE_TYPE_P3_2XLARGE = "p3.2xlarge"
INSTANCE_TYPE_P3_8XLARGE = "p3.8xlarge"
INSTANCE_TYPE_P3_16XLARGE = "p3.16xlarge"
INSTANCE_TYPE_P3DN_24XLARGE = "p3dn.24xlarge"
INSTANCE_TYPE_R5_LARGE = "r5.large"
INSTANCE_TYPE_R5_XLARGE = "r5.xlarge"
INSTANCE_TYPE_R5_2XLARGE = "r5.2xlarge"
INSTANCE_TYPE_R5_4XLARGE = "r5.4xlarge"
INSTANCE_TYPE_R5_12XLARGE = "r5.12xlarge"
INSTANCE_TYPE_R5_24XLARGE = "r5.24xlarge"
INSTANCE_TYPE_R5D_LARGE = "r5d.large"
INSTANCE_TYPE_R5D_XLARGE = "r5d.xlarge"
INSTANCE_TYPE_R5D_2XLARGE = "r5d.2xlarge"
INSTANCE_TYPE_R5D_4XLARGE = "r5d.4xlarge"
INSTANCE_TYPE_R5D_12XLARGE = "r5d.12xlarge"
INSTANCE_TYPE_R5D_24XLARGE = "r5d.24xlarge"
INSTANCE_TYPE_Z1D_LARGE = "z1d.large"
INSTANCE_TYPE_Z1D_XLARGE = "z1d.xlarge"
INSTANCE_TYPE_Z1D_2XLARGE = "z1d.2xlarge"
INSTANCE_TYPE_Z1D_3XLARGE = "z1d.3xlarge"
INSTANCE_TYPE_Z1D_6XLARGE = "z1d.6xlarge"
INSTANCE_TYPE_Z1D_12XLARGE = "z1d.12xlarge"

def SecurityGroup(
    vpc_id,
    group_name=None,
    group_description=None,
    security_group_ingress=None,
    security_group_egress=None,
    tags=None,
):
    properties = {"VpcId": vpc_id}
    if group_name != None:
        properties["GroupName"] = group_name
    if group_description != None:
        properties["GroupDescription"] = group_description
    if security_group_ingress != None:
        properties["SecurityGroupIngress"] = security_group_ingress
    if security_group_egress != None:
        properties["SecurityGroupEgress"] = security_group_egress
    if tags != None:
        properties["Tags"] = [
            {"Key": key, "Value": value} for key, value in tags.items()
        ]
    return Resource(type="AWS::EC2::SecurityGroup", properties=properties)

def SecurityGroupIngress(
    group_id=None,
    source_security_group_id=None,
    description=None,
    ip_protocol=None,
    from_port=None,
    to_port=None,
    depends_on=None,
):
    properties = {}
    if group_id != None:
        properties["GroupId"] = group_id
    if source_security_group_id != None:
        properties["SourceSecurityGroupId"] = source_security_group_id
    if description != None:
        properties["Description"] = description
    if ip_protocol != None:
        properties["IpProtocol"] = ip_protocol
    if from_port != None:
        properties["FromPort"] = from_port
    if to_port != None:
        properties["ToPort"] = to_port
    return Resource(
        type="AWS::EC2::SecurityGroupIngress",
        properties=properties,
        depends_on=depends_on,
    )

def SecurityGroupEgress(
    group_id,
    destination_security_group_id=None,
    description=None,
    ip_protocol=None,
    from_port=None,
    to_port=None,
    depends_on=None,
    cidr_ip=None,
):
    properties = {}
    if description != None:
        properties["Description"] = description
    properties["GroupId"] = group_id
    if destination_security_group_id != None:
        properties["DestinationSecurityGroupId"] = destination_security_group_id
    if ip_protocol != None:
        properties["IpProtocol"] = ip_protocol
    if from_port != None:
        properties["FromPort"] = from_port
    if to_port != None:
        properties["ToPort"] = to_port
    if cidr_ip != None:
        properties["CidrIp"] = cidr_ip
    return Resource(
        type="AWS::EC2::SecurityGroupEgress",
        properties=properties,
        depends_on=depends_on,
    )

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group-rule.html
def SecurityGroupRule(
    ip_protocol,
    cidr_ip=None,
    cidr_ipv6=None,
    description=None,
    destination_prefix_list_id=None,
    destination_security_group_id=None,
    from_port=None,
    source_security_group_id=None,
    source_security_group_name=None,
    source_security_group_owner_id=None,
    to_port=None,
):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group-rule.html"""
    properties = {"IpProtocol": ip_protocol}
    if cidr_ip != None:
        properties["CidrIp"] = cidr_ip
    if cidr_ipv6 != None:
        properties["CidrIpv6"] = cidr_ipv6
    if description != None:
        properties["Description"] = description
    if destination_prefix_list_id != None:
        properties["DestinationPrefixListId"] = destination_prefix_list_id
    if destination_security_group_id != None:
        properties["DestinationSecurityGroupId"] = destination_security_group_id
    if from_port != None:
        properties["FromPort"] = from_port
    if source_security_group_id != None:
        properties["SourceSecurityGroupId"] = source_security_group_id
    if source_security_group_name != None:
        properties["SourceSecurityGroupName"] = source_security_group_name
    if source_security_group_owner_id != None:
        properties["SourceSecurityGroupOwnerId"] = source_security_group_owner_id
    if to_port != None:
        properties["ToPort"] = to_port
    return properties