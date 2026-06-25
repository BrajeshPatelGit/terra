
# Using count.index to differentiate between the resources created with the count parameter.

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

resource "aws_iam_user" "app" {
  name  = "app_user${count.index}"
  count = 2
  tags = {
    Name = "dolfined_user${count.index}"
  }
}

# the below will also give an error without interpolation

# resource "aws_iam_user" "app" {
#   name  = "app_user[count.index]"
#   count = 2
# }




