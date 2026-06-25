# This exercise demonstrates how to use registry modules from terraform registry

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

# Registry that creates EC2 instances
## https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.1"
}


## VPC Modules Path
## https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest


# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.8.1"
# }


## details for the arguments
## https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/README.md


# # registry to create a VPC
# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "5.8.1"
#   cidr = "172.16.0.0/16"
#   create_igw = "true"
#   name = "My_VPC" 
# }



## IAM Module Path
## https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest

## IAM example where there is no main.tf to the repo
# this one alone will not create anything

# module "iam" {
#   source  = "terraform-aws-modules/iam/aws"
#   version = "5.39.1"
# }

# browse the terraform registry for IAM, you will find there is no main.tf file. But there are multiple modules for the different IAM services within the IAM umbrella.
  

# module "iam_user" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-user"
#   name          = "John.Smith"
#   password_reset_required = false
# }


## ECS module - a demonstration to show that some modules require input arguments to function. 

## https://registry.terraform.io/modules/terraform-aws-modules/ecs/aws/latest

# module "ecs" {
#   source  = "terraform-aws-modules/ecs/aws"
#   version = "5.11.4"
#   cluster_name = "mycluster"
#   }


