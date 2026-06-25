
# demo using locals block to define common argument values that can be reused in multiple places in the configuration. 


provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

locals {
  # Common tags to be assigned to all resources
  tags_info = {
    owner   = "dolfined_dev"
    service = "database"
  }
}

resource "aws_instance" "myec2_1" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  tags          = local.tags_info
}

resource "aws_instance" "myec2_2" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.nano"
  tags          = local.tags_info
}



## Example 2 - Using a reference to locals inside another locals block ### 

# locals {
#     service_name = "domain_name"
# }

# locals {
#   service_owner = "Dev_team"
# }

# locals {
#   # Common tags to be assigned to all resources 
#   tags_info = {
#     service = local.service_name
#     owner   = local.service_owner
#   }
# }

# resource "aws_instance" "myec2_1" {
#   ami           = "ami-0bb84b8ffd87024d8"
#   instance_type = "t2.micro"
#   tags          = local.tags_info
# }





#### Example 3 - Using variables inside a locals block #### 

# variable environment{}

# variable project_name{}

# locals {
#   # Define the bucket name based on some variables
#   bucket_name = "my-bucket-${var.environment}-${var.project_name}"
#   }

# resource "aws_s3_bucket" "dolfined_bucket" {
# bucket = local.bucket_name
# }

# output "bucket_name_display" {
#   value = aws_s3_bucket.dolfined_bucket.id
# }