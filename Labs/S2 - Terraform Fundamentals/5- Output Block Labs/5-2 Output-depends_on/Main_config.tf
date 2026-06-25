resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

}

# Note: the resource to create an ingress rule in the security group is aws_vpc_security_group_ingress_rule

resource "aws_vpc_security_group_ingress_rule" "allow_tls" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


# Note: the resource to create an egress rule in the security group is aws_vpc_security_group_egress_rule

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# Create a public subnet in the VPC to launch the EC2 instance in


resource "aws_subnet" "Public_Subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}


resource "aws_instance" "web" {
  ami                    = "ami-026b57f3c383c2eec"
  instance_type          = "t2.micro"
  associate_public_ip_address ="true"
  subnet_id              = aws_subnet.Public_Subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

}

output "instance_ip_addr" {
  value       = aws_instance.web.public_ip
  description = "The public IP address of the main web server instance."

  depends_on = [aws_vpc_security_group_ingress_rule.allow_tls]
  # Security group rule must be created before this IP address could actually be used, otherwise the services will be unreachable.

}
