
#
# Janky front-end for EC2
# 
#


REGION_CAC1=ca-central-1
REGION_USW2=us-west-2

#==============================

#
# see here for latest instance types: 
#   https://ca-central-1.console.aws.amazon.com/ec2/v2/home?region=ca-central-1#InstanceTypes:
#
FREETIER=t2.micro

T2C1M1=t2.micro
T2C1M2=t2.small
T2C2M4=t2.medium

# USD 0.0928/hr
T2C2M8=t2.large

T2C4M16=t2.xlarge
T2C8M32=t2.2xlarge

# USD 0.10/hr
M4C2M8=m4.large
M4C16M64=m4.4xlarge

#===
# ARM:
# USD 0.077/hr
M6C2M8=m6g.large

#==============================

# g4dn.2xlarge = 8 vCPUs; 4 Cores; x86_64; 32GB; Nvidia T4 w/16GB; USD0.835/hr
GPU1=g4dn.2xlarge

#==============================

AMI_UBUNTU20_X86=ami-036d46416a34a611c
AMI_UBUNTU20_ARM=ami-017d56f5127a80893 

# Deep Learning AMI (Amazon Linux 2) Version 55.0
# MXNet-1.8.0 & 1.7.0, TensorFlow-2.4.3, 2.3.4 & 1.15.5, PyTorch-1.7.1 & 1.8.1, Neuron, & others. NVIDIA CUDA, cuDNN, NCCL, Intel MKL-DNN, Docker, NVIDIA-Docker & EFA support. 
AMI_AMAZONLINUX_X86_HAS_DOCKER=ami-0950661c2ad2e7cde

# Deep Learning Base AMI (Amazon Linux 2) Version 47.0
# Built with NVIDIA CUDA, cuDNN, NCCL, GPU Drivers, Intel MKL-DNN, Docker, NVIDIA-Docker and EFA support. 
AMI_FOR_GPU=ami-052d016a605f10da4

#==============================
#
# TODO: Adjust from this point on
#


REGION=$(REGION_USW2)

INSTANCE=$(M6C2M8)
IMAGE=$(AMI_UBUNTU20_ARM)

#
# You need to specify a security group id and a subnet id. A default for each will have been 
# created for you after you use the web console to launch an EC2 instance.
#
# For your security group, either:
#  1. https://us-west-2.console.aws.amazon.com/ec2/v2/home?region=us-west-2#SecurityGroups:
#  2. aws ec2 describe-security-groups --output json | jq '.SecurityGroups[].GroupId'
#
# For your subnet, either:
#  1. https://us-west-2.console.aws.amazon.com/vpc/home?region=us-west-2#subnets:
#  2. aws ec2 describe-subnets --output json | jq '.Subnets[].SubnetId'
#

SGI_WFH=look-up-your-security-group-id
SNET=look-up-your-subnet-id

# Optional for updating your WFH rule
SGRI_WFH=look-up-the-rule

#
# Specify the name of your key-pair; 
#  1. https://ca-central-1.console.aws.amazon.com/ec2/v2/home?region=ca-central-1#KeyPairs:
#  2. aws ec2 describe-key-pairs
#
KEY=specify-your-key
LKEY=~/.ssh/your-key-file-name

#==============================


SHUTDOWN_BEH=terminate

# this is used to provide value for the tag mnemonic-name to make instances easier to recognize/recall a la Docker
NAMING_SVC=https://frightanic.com/goodies_content/docker-names.php


.phony=sgr sg up ssh arm ssh-arm 

sgr:
	aws --region us-west-2 --output json ec2 describe-security-group-rules --security-group-rule-ids $(SGRI_WFH)

sg:
	aws --region us-west-2 --output json ec2 describe-security-groups --group-id $(SGI_WFH)

#
# this saves the public IP of the instance into up-ip.log which is used hand-off to the ssh target for seamless login
# up-id.log contains the instance id
# 
up:
	aws --region $(REGION) --output json ec2 run-instances \
		--instance-type $(T2C4M16) \
		--image-id $(AMI_UBUNTU20_X86) \
		--instance-initiated-shutdown-behavior $(SHUTDOWN_BEH) \
		--subnet-id $(SNET) \
		--security-group-ids $(SGI_WFH) \
		--key-name $(KEY) \
                --tag-specifications 'ResourceType=instance,Tags=[{Key=mnemonic-name,Value='`curl --silent $(NAMING_SVC)`'}]' \
			| tee up.log | jq -r '.Instances[].InstanceId' > up-id.log
	aws ec2 wait --instance-id `cat up-id.log`
	aws --region $(REGION) --output json ec2 describe-instances --instance-id `cat up-id.log` | tee up.log | jq -r '.Reservations[].Instances[].PublicIpAddress' > up-ip.log
        jq -r '.Reservations[].Instances[]| .PublicIpAddress + " " + .Tags[0].Value' up.log

ssh:
	ssh -i $(LKEY) ubuntu@`cat up-ip.log`

#
# a second target of convenience for an alternate architecture?
#
arm:
	aws --region $(REGION) --output json ec2 run-instances \
		--instance-type $(M6C2M8) \
		--image-id $(AMI_UBUNTU20_ARM) \
		--instance-initiated-shutdown-behavior $(SHUTDOWN_BEH) \
		--subnet-id $(SNET) \
		--security-group-ids $(SGI_WFH) \
		--key-name $(KEY) | tee arm.log | jq -r '.Instances[].InstanceId' > arm-id.log
	aws ec2 wait --instance-id `cat arm-id.log`
	aws --region $(REGION) --output json ec2 describe-instances --instance-id `cat arm-id.log` | tee arm.log | jq -r '.Reservations[].Instances[].PublicIpAddress' > arm-ip.log
        jq -r '.Reservations[].Instances[]| .PublicIpAddress + " " + .Tags[0].Value' arm.log
	
ssh-arm:
	ssh -i $(LKEY) ubuntu@`cat arm-ip.log`

