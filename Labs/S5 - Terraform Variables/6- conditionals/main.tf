/* 
Using conditionals to determine which instance type to launch and the number of instance. 
, the development or production which is determined through the count, and the count value is determined by the conditional environment_used_is
*/

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

variable "environment" {}

resource "aws_instance" "myec2_development" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.micro"
  count         = var.environment == "dev" ? 2 : 0
}

resource "aws_instance" "myec2_production" {
  ami           = "ami-0bb84b8ffd87024d8"
  instance_type = "t2.small"
  count         = var.environment == "prod" ? 3 : 0
}


