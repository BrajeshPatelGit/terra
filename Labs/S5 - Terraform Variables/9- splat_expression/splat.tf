provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

# resource "aws_iam_user" "sys_adm" {
#   name  = "sys_adm${count.index}"
#   count = 5
# }

# output "ARNs" {
#   value = aws_iam_user.sys_adm[*].arn
# }

# output "ARNs_specific" {
#   value = aws_iam_user.sys_adm[*].name
# }



##### Example - 2 Splat Expression to list AZs in a region #####


data "aws_availability_zones" "available" {}

output "available_zones" {
  value = data.aws_availability_zones.available.names[*]
}

output "available_zones1" {
  value = data.aws_availability_zones.available.names[4]
}
