module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["ap-south-1a"]
  public_subnets = ["10.0.1.0/24"]

  map_public_ip_on_launch = true

  tags = { Name = "main-vpc" }
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name          = "main-ec2"
  ami           = "ami-0d351f1b760a30161"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[0]

  vpc_security_group_ids = [module.sg.security_group_id]

  tags = { Name = "main-ec2" }
}

module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name   = "main-sg"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
  ]
  egress_rules = ["all-all"]
}
