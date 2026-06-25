# demonstrate the use of for.each meta argument.

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

#### List Example - toset()

resource "aws_iam_user" "it_team" {
  for_each = toset(["user4", "user5", "user12", "user6", "user7", "user8", "user9", "user10", "user11"])
  name     = each.key
}


#### Map Example ####

##############  Another example using EC2 instance resources with for.each to show its flexibility compared to count and count.index


# resource "aws_instance" "myec2" {
#   for_each = {
#     "instance_1"  = "t2.micro"
#     "instance_2"  = "t2.medium"
#   }
#   ami           = "ami-0bb84b8ffd87024d8"
#   instance_type = each.value
#   tags = {
 
#     Name = "Web_${each.key}"
#     # Name = each.key
#   }
# }


## A different way to write the previous example with the map inside the resource allocated to the for_each directly


# variable "instance_types" {
#   type = map(any)
#   default = {"instance_1"= "t2.micro", "instance_2"= "t2.medium"}
# }

# resource "aws_instance" "myec2" {
#   for_each = var.instance_types
#   ami           = "ami-0bb84b8ffd87024d8"
#   instance_type = each.value
#   tags = {
#     Name = "Web_${each.key}"
      # Name = each.key
#   }
# }



