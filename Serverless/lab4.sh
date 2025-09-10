import boto3
instances = ['replace with instance id']
ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=instances)
    print("stopped the running instance " + str(instances))


## OR

import boto3
region = 'eu-central-1'
instances =  ['replace with instance id']
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=instances)
    print("stopped the running instance" + str(instances))

##Task 6

import boto3
instances = ['enter your ec2 instance id']
ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    ec2.start_instances(InstanceIds=instances)
    print("started the running instance" + str(instances))


##Task 7

import boto3
instances =  ['enter your ec2 instance id']
ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    ec2.terminate_instances(InstanceIds=instances)
    print("terminated the running instance" + str(instances))





