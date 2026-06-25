
#### Demo 1 - How to define providers in your Terraform code ####

####   1 ) in a provider block   ####
## this is the way it was done in earlier versions

provider "aws" {
  region  = "us-east-1"
  # profile = "dev_admin"
}




#### 2 ) in the Terraform Block - Required Providers ####
## this is the way it is done in newer versions

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#     azure = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }


# Both will work. If you need to specify version and source, then   # use the required_providers  way
# Credentials for provider authentication can not be provided through the terraform block. They need to be configured under the provider block (using profile or access key pair)or through Environment variables. 
