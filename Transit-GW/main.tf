terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

variable "vpcs" {
  description = "Map of VPCs to create"
  type = map(object({
    cidr_block  = string
    subnet_cidr = string
    az          = string
  }))

  default = {
    vpc1 = {
      cidr_block  = "10.0.0.0/16"
      subnet_cidr = "10.0.1.0/24"
      az          = "ap-south-1a"
    }
    vpc2 = {
      cidr_block  = "10.1.0.0/16"
      subnet_cidr = "10.1.1.0/24"
      az          = "ap-south-1b"
    }
    vpc3 = {
      cidr_block  = "10.2.0.0/16"
      subnet_cidr = "10.2.1.0/24"
      az          = "ap-south-1c"
    }
    vpc4 = {
      cidr_block  = "10.3.0.0/16"
      subnet_cidr = "10.3.1.0/24"
      az          = "ap-south-1a"
    }
  }
}

variable "resource_names" {
  description = "Name tags for each VPC, subnet, internet gateway, and route table"
  type = map(object({
    vpc_name              = string
    subnet_name           = string
    internet_gateway_name = string
    route_table_name      = string
  }))

  default = {
    vpc1 = {
      vpc_name              = "vpc1"
      subnet_name           = "vpc1-public-subnet"
      internet_gateway_name = "vpc1-igw"
      route_table_name      = "vpc1-public-rt"
    }
    vpc2 = {
      vpc_name              = "vpc2"
      subnet_name           = "vpc2-public-subnet"
      internet_gateway_name = "vpc2-igw"
      route_table_name      = "vpc2-public-rt"
    }
    vpc3 = {
      vpc_name              = "vpc3"
      subnet_name           = "vpc3-public-subnet"
      internet_gateway_name = "vpc3-igw"
      route_table_name      = "vpc3-public-rt"
    }
    vpc4 = {
      vpc_name              = "vpc4"
      subnet_name           = "vpc4-public-subnet"
      internet_gateway_name = "vpc4-igw"
      route_table_name      = "vpc4-public-rt"
    }
  }
}

variable "instance_key_pairs" {
  description = "EC2 key pair names for each VPC"
  type        = map(string)

  default = {
    vpc1 = "keypair-vpc1"
    vpc2 = "keypair-vpc2"
    vpc3 = "keypair-vpc3"
    vpc4 = "keypair-vpc4"
  }
}

resource "aws_vpc" "this" {
  for_each = var.vpcs

  cidr_block = each.value.cidr_block

  tags = {
    Name = var.resource_names[each.key].vpc_name
  }
}

resource "aws_subnet" "public" {
  for_each = var.vpcs

  vpc_id                  = aws_vpc.this[each.key].id
  cidr_block              = each.value.subnet_cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = var.resource_names[each.key].subnet_name
  }
}

resource "aws_internet_gateway" "this" {
  for_each = var.vpcs

  vpc_id = aws_vpc.this[each.key].id

  tags = {
    Name = var.resource_names[each.key].internet_gateway_name
  }
}

resource "aws_route_table" "public" {
  for_each = var.vpcs

  vpc_id = aws_vpc.this[each.key].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this[each.key].id
  }

  tags = {
    Name = var.resource_names[each.key].route_table_name
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.vpcs

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}

resource "aws_security_group" "public" {
  for_each = var.vpcs

  name        = "${var.resource_names[each.key].vpc_name}-sg"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.this[each.key].id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.resource_names[each.key].vpc_name}-sg"
  }
}

resource "aws_instance" "this" {
  for_each = var.vpcs

  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public[each.key].id
  key_name               = var.instance_key_pairs[each.key]
  vpc_security_group_ids = [aws_security_group.public[each.key].id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.resource_names[each.key].vpc_name}-ec2"
  }
}
