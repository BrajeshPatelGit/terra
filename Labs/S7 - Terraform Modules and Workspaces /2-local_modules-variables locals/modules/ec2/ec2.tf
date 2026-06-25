###### ( 1 ) ### with variables #####
#### demonstrate that static values in the main configuration file will override the values in the variables. This is why we opt to use locals if we need to now allow this to happen


variable "ec2_instance" {
  default = "t2.small"
}

variable "ec2_ami" {
  default = "ami-00beae93a2d981137"
}

resource "aws_instance" "myec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance
}




######## ( 2 ) ### With Locals ######
## use locals to supply the required values to the main module and demonstrate how locals will not allow the override using values in the root module.

# locals {
#   ec2_instance = "t2.nano"
# }

# locals {
#   ec2_ami = "ami-00beae93a2d981137"
# }

# resource "aws_instance" "myec2" {
#   ami           = local.ec2_ami
#   instance_type = local.ec2_instance
# }




