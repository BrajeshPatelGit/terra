# 1. Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# 2. Fetch the latest Ubuntu 22.04 LTS AMI automatically
data "aws_ami" "ubuntu_22_04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 3. Create a Security Group to open Port 80 (HTTP) and Port 22 (SSH)
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-webserver-sg"
  description = "Allow inbound HTTP and SSH traffic"

  # Inbound HTTP rule
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound SSH rule (Restricting this to your IP is recommended)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound all traffic rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 4. Provision the EC2 Instance and Bootstrap Nginx
resource "aws_instance" "nginx_server" {
  ami                    = data.aws_ami.ubuntu_22_04.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]

  # Bash script executed on first boot to install Nginx
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install nginx -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Nginx-Terraform-Webserver"
  }
}

# 5. Output the public IP to access the webserver easily
output "nginx_public_ip" {
  value       = aws_instance.nginx_server.public_ip
  description = "The public IP address of the Nginx web server"
}
