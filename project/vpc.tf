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
    Name = "NATGW"
  }

  igw_tags = {
    Name = "pro-IG"
  }

  public_route_table_tags = {
    Name = "Public_RT"
  }

  private_route_table_tags = {
    Name = "Private_RT"
  }
}
