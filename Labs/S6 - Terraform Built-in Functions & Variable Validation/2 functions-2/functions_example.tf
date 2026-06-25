
#### An AWS example employing Terraform Functions ####
# note the region definition

provider "aws" {
  region  = var.region     ## 
  profile = "dev_admin"
}

variable "region" {
  # default = "us-east-1"
}

data "aws_availability_zones" "current_region_azs" {}

variable "ec2_tags" {
  type    = list(any)
  default = ["instance_a", "instance_b"]
}

variable "ami_reg" {
  type = map(any)
  default = {
    "us-east-1"  = "ami-0bb84b8ffd87024d8"
    "eu-west-1"  = "ami-0ac67a26390dc374d"
    "us-west-2"  = "ami-01cd4de4363ab6ee8"
  }
}

resource "aws_instance" "app-dev" {
  ami           = lookup(var.ami_reg, var.region)
  
  instance_type = "t2.micro"

  availability_zone = data.aws_availability_zones.current_region_azs.names[count.index]
  count         = 2
 
  tags = {
    Name = element(var.ec2_tags, count.index)
  }
}