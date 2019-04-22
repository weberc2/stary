load("cloudformation/builtins", "Resource")

SERVICE_LAUNCH_TYPE_FARGATE = "FARGATE"
ASSIGN_PUBLIC_IP_ENABLED = "ENABLED"
ASSIGN_PUBLIC_IP_DISABLED = "DISABLED"

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-taskdefinition-containerdefinitions-logconfiguration.html
def LogConfiguration(log_driver, options=None):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-taskdefinition-containerdefinitions-logconfiguration.html"""
    properties = {"LogDriver": log_driver}
    if options != None:
        properties["Options"] = options
    return properties

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-taskdefinition-containerdefinitions.html
def ContainerDefinition(
    name,
    image,
    command=None,
    cpu=None,
    memory=None,
    depends_on=None,
    disable_networking=None,
    dns_search_domains=None,
    dns_servers=None,
    docker_labels=None,
    docker_security_options=None,
    entry_point=None,
    environment=None,
    essential=None,
    extra_hosts=None,
    health_check=None,
    hostname=None,
    links=None,
    linux_parameters=None,
    log_configuration=None,
    memory_reservation=None,
    mount_points=None,
    port_mappings=None,
    privileged=None,
    readonly_root_filesystem=None,
    repository_credentials=None,
    start_timeout=None,
    stop_timeout=None,
    ulimits=None,
    volumes_from=None,
    working_directory=None,
):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-taskdefinition-containerdefinitions.html"""
    properties = {"Name": name, "Image": image}
    if command != None:
        properties["Command"] = command
    if cpu != None:
        properties["Cpu"] = cpu
    if memory != None:
        properties["Memory"] = memory
    if depends_on != None:
        properties["DependsOn"] = depends_on
    if disable_networking != None:
        properties["DisableNetworking"] = disable_networking
    if dns_search_domains != None:
        properties["DnsSearchDomains"] = dns_search_domains
    if dns_servers != None:
        properties["DnsServers"] = dns_servers
    if docker_labels != None:
        properties["DockerLabels"] = docker_labels
    if docker_security_options != None:
        properties["DockerSecurityOptions"] = docker_security_options
    if entry_point != None:
        properties["EntryPoint"] = entry_point
    if environment != None:
        properties["Environment"] = environment
    if essential != None:
        properties["Essential"] = essential
    if extra_hosts != None:
        properties["ExtraHosts"] = extra_hosts
    if health_check != None:
        properties["HealthCheck"] = health_check
    if hostname != None:
        properties["Hostname"] = hostname
    if links != None:
        properties["Links"] = links
    if linux_parameters != None:
        properties["LinuxParameters"] = linux_parameters
    if log_configuration != None:
        properties["LogConfiguration"] = log_configuration
    if memory_reservation != None:
        properties["MemoryReservation"] = memory_reservation
    if mount_points != None:
        properties["MountPoints"] = mount_points
    if port_mappings != None:
        properties["PortMappings"] = port_mappings
    if privileged != None:
        properties["Privileged"] = privileged
    if readonly_root_filesystem != None:
        properties["ReadonlyRootFilesystem"] = readonly_root_filesystem
    if repository_credentials != None:
        properties["RepositoryCredentials"] = repository_credentials
    if start_timeout != None:
        properties["StartTimeout"] = start_timeout
    if stop_timeout != None:
        properties["StopTimeout"] = stop_timeout
    if ulimits != None:
        properties["Ulimits"] = ulimits
    if volumes_from != None:
        properties["VolumesFrom"] = volumes_from
    if working_directory != None:
        properties["WorkingDirectory"] = working_directory
    return properties

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html
def TaskDefinition(
    container_definitions,
    task_role_arn=None,
    execution_role_arn=None,
    cpu=None,
    memory=None,
    volumes=None,
    network_mode=None,
    family=None,
    placement_constraints=None,
    requires_compatibilities=None,
    proxy_configuration=None,
):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html"""
    properties = {"ContainerDefinitions": container_definitions}
    if task_role_arn != None:
        properties["TaskRoleArn"] = task_role_arn
    if execution_role_arn != None:
        properties["ExecutionRoleArn"] = execution_role_arn
    if cpu != None:
        properties["Cpu"] = cpu
    if memory != None:
        properties["Memory"] = memory
    if volumes != None:
        properties["Volumes"] = volumes
    if network_mode != None:
        properties["NetworkMode"] = network_mode
    if family != None:
        properties["Family"] = family
    if placement_constraints != None:
        properties["PlacementConstraints"] = None
    if requires_compatibilities != None:
        properties["RequiresCompatibilities"] = requires_compatibilities    
    if proxy_configuration != None:
        properties["ProxyConfiguration"] = proxy_configuration
    return Resource(type="AWS::ECS::TaskDefinition", properties=properties)

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-service-deploymentconfiguration.html
def ServiceDeploymentConfiguration(
    maximum_percent=None,
    minimum_healthy_percent=None,
):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-service-deploymentconfiguration.html"""
    properties = {}
    if maximum_percent != None:
        properties["MaximumPercent"] = maximum_percent
    if minimum_healthy_percent != None:
        properties["MinimumHealthyPercent"] = minimum_healthy_percent
    return properties

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-service-awsvpcconfiguration.html
def ServiceAWSVPCConfiguration(
    subnets,
    assign_public_ip=None,
    security_groups=None,
):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-service-awsvpcconfiguration.html"""
    properties = {"Subnets": subnets}
    if assign_public_ip != None:
        properties["AssignPublicIp"] = assign_public_ip
    if security_groups != None:
        properties["SecurityGroups"] = security_groups
    return properties

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-service-networkconfiguration.html
def ServiceNetworkConfiguration(awsvpc_configuration):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-service-networkconfiguration.html"""
    properties = {}
    if awsvpc_configuration != None:
        properties["AwsvpcConfiguration"] = awsvpc_configuration
    return properties

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-service-loadbalancers.html
def ServiceLoadBalancers(
    container_name,
    container_port,
    load_balancer_name=None,
    target_group_arn=None,
):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ecs-service-loadbalancers.html"""
    properties = {
        "ContainerName": container_name,
        "ContainerPort": container_port,
    }
    if load_balancer_name != None:
        properties["LoadBalancerName"] = load_balancer_name
    if target_group_arn != None:
        properties["TargetGroupArn"] = target_group_arn
    return properties

# https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-service.html
def Service(
    task_definition,
    cluster=None,
    deployment_configuration=None,
    desired_count=None,
    health_check_grace_period_seconds=None,
    launch_type=None,
    load_balancers=None,
    network_configuration=None,
    placement_constraints=None,
    platform_version=None,
    role=None,
    scheduling_strategy=None,
    service_name=None,
    service_registries=None,
):
    """https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-service.html"""
    properties={"TaskDefinition": task_definition}
    if cluster != None:
        properties["Cluster"] = cluster
    if deployment_configuration != None:
        properties["DeploymentConfiguration"] = deployment_configuration
    if desired_count != None:
        properties["DesiredCount"] = desired_count
    if health_check_grace_period_seconds != None:
        properties["HealthCheckGracePeriodSeconds"] = health_check_grace_period_seconds
    if launch_type != None:
        properties["LaunchType"] = launch_type
    if load_balancers != None:
        properties["LoadBalancers"] = load_balancers
    if network_configuration != None:
        properties["NetworkConfiguration"] = network_configuration
    if placement_constraints != None:
        properties["PlacementConstraints"] = placement_constraints
    if platform_version != None:
        properties["PlatformVersion"] = platform_version
    if role != None:
        properties["Role"] = role
    if scheduling_strategy != None:
        properties["SchedulingStrategy"] = scheduling_strategy
    if service_name != None:
        properties["ServiceName"] = service_name
    if service_registries != None:
        properties["ServiceRegistries"] = service_registries
    return Resource(type="AWS::ECS::Service", properties=properties)

def Cluster(cluster_name=None):
    properties = {}
    if cluster_name != None:
        properties["ClusterName"] = cluster_name
    return Resource(type="AWS::ECS::Cluster", properties=properties)