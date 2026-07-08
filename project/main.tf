provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "pro-vpc"

  tags = {
    Name       = "pro-vpc"
    created_by = "terra+awsQ"
  }
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24"]

  public_subnet_names  = ["pub-sub11", "pub-sub22"]
  private_subnet_names = ["pri-sub11", "pri-sub22"]

  map_public_ip_on_launch = true

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  nat_gateway_tags = {
    "ap-south-1a" = { Name = "NATGW1" }
    "ap-south-1b" = { Name = "NATGW2" }
  }

  igw_tags = {
    Name = "pro-IG"
  }
}

module "web_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name   = "WebSG"
  vpc_id = module.vpc.vpc_id

  ingress_rules       = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name   = "ALBSG"
  vpc_id = module.vpc.vpc_id

  ingress_rules       = ["http-80-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}
