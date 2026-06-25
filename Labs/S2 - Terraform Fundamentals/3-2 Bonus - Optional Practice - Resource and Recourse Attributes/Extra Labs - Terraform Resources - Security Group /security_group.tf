
# Create a VPC and create a security group. 
# The security group will be within the VPC. use allow_http_tls as the name. 
# The security group will have an inbound (ingress) rule allowing HTTP and  HTTPS (ports 80 and 443) from the VPC CIDR block,  and an outbound (egress) rules allowing all ports to all destinations. 


# Create the VPC

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name= "custom_VPC"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"     # all traffic (all protocols/ports) 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_tls"
  }
}

