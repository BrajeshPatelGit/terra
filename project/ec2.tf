module "web_serv11" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name          = "web-serv11"
  ami           = "ami-01a18c38ece67e620"
  instance_type = "t2.micro"
  key_name      = "keypair-vpc1"

  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.web_sg.security_group_id]

  tags = {
    Name = "web-serv11"
  }
}

module "web_serv22" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name          = "web-serv22"
  ami           = "ami-01a18c38ece67e620"
  instance_type = "t2.micro"
  key_name      = "keypair-vpc1"

  subnet_id              = module.vpc.public_subnets[1]
  vpc_security_group_ids = [module.web_sg.security_group_id]

  tags = {
    Name = "web-serv22"
  }
}
