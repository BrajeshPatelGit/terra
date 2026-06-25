# Creating a new VPC, a new Subnet and an EC2 instance
# referencing attributes from modules.

module "myvpc" {
  source = "../modules/vpc"
}

module "mysg" {
  source = "../modules/sg"
}

resource "aws_subnet" "newsubnet" {
  vpc_id     = module.myvpc.vpcid123
  cidr_block = "10.0.1.0/24"
}

resource "aws_instance" "app" {
  ami                    = "ami-00beae93a2d981137"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.mysg.sgid123]

  }
