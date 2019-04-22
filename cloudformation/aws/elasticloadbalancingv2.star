load("cloudformation/builtins", "Resource")

SCHEME_INTERNAL = "internal"
SCHEME_INTERNET_FACING = "internet-facing"

def LoadBalancer(
        ip_address_type = None,
        load_balancer_attributes = None,
        name = None,
        scheme = None,
        security_groups = None,
        subnet_mappings = None,
        subnets = None,
        tags = None,
        type_ = None):
    properties = {}
    if ip_address_type != None:
        properties["IpAddressType"] = ip_address_type
    if load_balancer_attributes != None:
        properties["LoadBalancerAttributes"] = load_balancer_attributes
    if name != None:
        properties["Name"] = name
    if scheme != None:
        properties["Scheme"] = scheme
    if security_groups != None:
        properties["SecurityGroups"] = security_groups
    if subnet_mappings != None:
        properties["SubnetMappings"] = subnet_mappings
    if subnets != None:
        properties["Subnets"] = subnets
    if tags != None:
        properties["Tags"] = tags
    if type_ != None:
        properties["Type"] = type_
    return Resource(
        type = "AWS::ElasticLoadBalancingV2::LoadBalancer",
        properties = properties,
    )

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-targetgroup.html
def TargetGroup(
        health_check_enabled = None,
        health_check_interval_seconds = None,
        health_check_path = None,
        health_check_port = None,
        health_check_protocol = None,
        health_check_timeout_seconds = None,
        healthy_threshold_count = None,
        matcher = None,
        name = None,
        port = None,
        protocol = None,
        tags = None,
        target_group_attributes = None,
        targets = None,
        target_type = None,
        unhealthy_threshold_count = None,
        vpc_id = None,
        depends_on = None):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-targetgroup.html"""
    properties = {}
    if health_check_enabled != None:
        properties["HealthCheckEnabled"] = health_check_enabled
    if health_check_interval_seconds != None:
        properties["HealthCheckIntervalSeconds"] = health_check_interval_seconds
    if health_check_path != None:
        properties["HealthCheckPath"] = health_check_path
    if health_check_port != None:
        properties["HealthCheckPort"] = health_check_port
    if health_check_protocol != None:
        properties["HealthCheckProtocol"] = health_check_protocol
    if health_check_timeout_seconds != None:
        properties["HealthCheckTimeoutSeconds"] = health_check_timeout_seconds
    if healthy_threshold_count != None:
        properties["HealthyThresholdCount"] = healthy_threshold_count
    if matcher != None:
        properties["Matcher"] = matcher
    if name != None:
        properties["Name"] = name
    if port != None:
        properties["Port"] = port
    if protocol != None:
        properties["Protocol"] = protocol
    if tags != None:
        properties["Tags"] = tags
    if target_group_attributes != None:
        properties["TargetGroupAttributes"] = target_group_attributes
    if targets != None:
        properties["Targets"] = targets
    if target_type != None:
        properties["TargetType"] = target_type
    if unhealthy_threshold_count != None:
        properties["UnhealthyThresholdCount"] = unhealthy_threshold_count
    if vpc_id != None:
        properties["VpcId"] = vpc_id
    return Resource(
        properties = properties,
        type = "AWS::ElasticLoadBalancingV2::TargetGroup",
        depends_on = depends_on,
    )

ACTION_TYPE_FORWARD = "forward"
ACTION_TYPE_AUTHENTICATE_OIDC = "authenticate-oidc"
ACTION_TYPE_AUTHENTICATE_COGNITO = "authenticate-cognito"
ACTION_TYPE_REDIRECT = "redirect"
ACTION_TYPE_FIXED_RESPONSE = "fixed-response"

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-elasticloadbalancingv2-listener-defaultactions.html
def Action(
        type,
        authenticate_cognito_config = None,
        authenticate_oidc_config = None,
        fixed_response_config = None,
        order = None,
        redirect_config = None,
        target_group_arn = None):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-elasticloadbalancingv2-listener-defaultactions.html"""
    properties = {"Type": type}
    if authenticate_cognito_config != None:
        properties["AuthenticateCognitoConfig"] = authenticate_cognito_config
    if authenticate_oidc_config != None:
        properties["AuthenticateOidcConfig"] = authenticate_oidc_config
    if fixed_response_config != None:
        properties["FixedResponseConfig"] = fixed_response_config
    if order != None:
        properties["Order"] = order
    if redirect_config != None:
        properties["RedirectConfig"] = redirect_config
    if target_group_arn != None:
        properties["TargetGroupArn"] = target_group_arn
    return properties

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener.html
def Listener(
        default_actions,
        load_balancer_arn,
        port,
        protocol,
        certificates = None,
        ssl_policy = None,
        depends_on = None):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticloadbalancingv2-listener.html"""
    properties = {
        "DefaultActions": default_actions,
        "LoadBalancerArn": load_balancer_arn,
        "Port": port,
        "Protocol": protocol,
    }
    if certificates != None:
        properties["Certificates"] = certificates
    if ssl_policy != None:
        properties["SslPolicy"] = ssl_policy
    return Resource(
        type = "AWS::ElasticLoadBalancingV2::Listener",
        properties = properties,
        depends_on = depends_on,
    )
