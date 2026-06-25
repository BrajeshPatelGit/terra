################## Implicit Dependancy############################
## Due to the instance attribute (.id) in the eip configuration block, Terraform understands that it needs to create the EC2 instance before the EIP such that it can associate the eip with the instance


provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

resource "aws_eip" "myeip" {
  domain = "vpc"
  instance = aws_instance.myec2.id
}

resource "aws_instance" "myec2" {
  instance_type = "t2.micro"
  ami           = "ami-07caf09b362be10b8"
}

