provider "aws" {
  region  = "ap-south-1"
  profile = "dev_admin"
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

resource "aws_instance" "myec2" {
  ami           = var.ami_var["ap-south-1"]
  instance_type = var.instance_types["ap-south-1"]
  subnet_id = aws_subnet.Public_Subnet1.id
}

resource "aws_subnet" "Public_Subnet1" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.az_var[2]
}

