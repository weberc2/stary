load("cloudformation/builtins", "Resource")

PAUSE_TIME_5M = "PT5M"

VOLUME_TYPE_GP2 = "gp2"

def UpdatePolicyAutoscalingRollingUpdate(
    max_batch_size,
    min_instances_in_service,
    pause_time,
):
    return{
        "AutoScalingRollingUpdate": {
            "MaxBatchSize": max_batch_size,
            "MinInstancesInService": min_instances_in_service,
            "PauseTime": pause_time,
        },
    }

def EBSSpec(volume_size, volume_type, delete_on_termination):
    return {
        "VolumeSize": volume_size,
        "VolumeType": volume_type,
        "DeleteOnTermination": delete_on_termination,
    }

def BlockDeviceMapping(device_name, ebs):
    return {"DeviceName": device_name, "Ebs": ebs}

def LaunchConfiguration(
    image_id,
    instance_type,
    iam_instance_profile,
    key_name=None,
    security_groups=None,
    associate_public_ip_address=None,
    block_device_mappings=None,
    user_data=None,
):
    properties = {
        "ImageId": image_id,
        "InstanceType": instance_type,
        "IamInstanceProfile": iam_instance_profile,
    }
    if key_name != None:
        properties["KeyName"] = key_name
    if security_groups != None:
        properties["SecurityGroups"] = security_groups
    if associate_public_ip_address != None:
        properties["AssociatePublicIpAddress"] = associate_public_ip_address
    if block_device_mappings != None:
        properties["BlockDeviceMappings"] = block_device_mappings
    if user_data != None:
        properties["UserData"] = user_data
    return Resource(type="AWS::AutoScaling::LaunchConfiguration", properties=properties)

def AutoScalingGroup(
    launch_configuration_name,
    desired_capacity,
    min_size,
    max_size,
    vpc_zone_identifier,
    tags,
    update_policy,
):
    return Resource(
        type="AWS::AutoScaling::AutoScalingGroup",
        properties={
            "LaunchConfigurationName": launch_configuration_name,
            "DesiredCapacity": desired_capacity,
            "MinSize": min_size,
            "MaxSize": max_size,
            "VPCZoneIdentifier": vpc_zone_identifier,
            "Tags": tags,
            "UpdatePolicy": update_policy,
        },
    )