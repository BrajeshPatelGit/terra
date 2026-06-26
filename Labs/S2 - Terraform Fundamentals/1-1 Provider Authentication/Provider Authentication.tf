#### Demo  - Provider Authentication ####
### Test 1 - 
### Lets try to create a VPC without specifying the credentials ###


# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "example_1" {
  cidr_block = "10.0.0.0/16"
}

## Why can't we create it?
# Answer : no credentials given to Terraform over AWS


/* Commands to view the details of a profile or to view all profiles configured on your AWS CLI
Aws configure list  to list the default profile
Aws configure list –profile <profile name> to list the configuration of a specific profile
aws configure list -profiles     lists all configured profiles
*/


### Let's try with embedding the access key in the provider block

## using Access key pair in the provider block

# provider "aws" {
#   region     = "us-east-1"
#   access_key = "$$"
#   secret_key = "$$"
# }




## Let's try again with a profile command

# Configure the AWS Provider
# provider "aws" {
#   region  = "us-east-1"
#   profile = "dev_admin"
# }

# # Create a VPC
# resource "aws_vpc" "example" {
#   cidr_block = "10.0.0.0/16"
# }

## Why did it work this time?
## Answer : because the dev_admin is a profile configured with the right permissions



###################  Other Methods to Configure Provider Authentication in the Provider Block are ################




# Using Environment Variables on the local machine (Export Environment Variables in the local machine, not in the Provider blick) 

# provider "aws" {}
# # export mention the aws access key is here ="00"
# # export mention the aws access secret key is here = ""
# # export AWS_REGION= "us-east-1"



### Using credentials files in the provider block referencing files on the local machine

# provider "aws" {
#   shared_config_files      = ["/Users/dolfined/.aws/config"]
#   shared_credentials_files = ["/Users/dolfined/.aws/credentials"]
#   profile                  = "dev_admin"
# }

#############################################
