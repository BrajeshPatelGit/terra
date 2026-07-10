locals {
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo " This is an app server in AWS Region AP-SOUTH-1 " > /var/www/html/index.html
  EOF
}

module "web_serv11" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "= 4.5.0"

  name          = "web-serv11"
  ami           = "ami-01a18c38ece67e620"
  instance_type = "t2.micro"
  key_name      = "keypair-vpc1"
  user_data     = local.user_data

  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.web_sg.security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm.name

  tags = {
    Name = "web-serv11"
  }
}

module "web_serv22" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "= 4.5.0"

  name          = "web-serv22"
  ami           = "ami-01a18c38ece67e620"
  instance_type = "t2.micro"
  key_name      = "keypair-vpc1"
  user_data     = local.user_data

  subnet_id              = module.vpc.public_subnets[1]
  vpc_security_group_ids = [module.web_sg.security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_ssm.name

  tags = {
    Name = "web-serv22"
  }
}
