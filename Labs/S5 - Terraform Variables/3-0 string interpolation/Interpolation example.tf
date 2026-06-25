/* This example shows why we must use  interpolation for some use cases. 
In the configuration below, if we use the 
[aws_eip.lb.public_ip] option, we will not be able to provide the subnet mask. 
With Interpolation, we can express the subnet mask along with the cross-resource reference used
*/

provider "aws" {
  region     = "us-east-1"
  profile  = "dev_admin"
}

resource "aws_eip" "EIP1" {
  domain = "vpc"
}

resource "aws_security_group" "allow_tls" {
  name        = "Test_security_group"
      ingress {
        description = "TLS from VPC"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["${aws_eip.EIP1.public_ip}/32"]
        # cidr_blocks = [aws_eip.EIP1.public_ip]
      }
      tags = {
        Name = "allow_tls"
      }
    }