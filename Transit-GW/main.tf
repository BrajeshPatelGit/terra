terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
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
      az          = "us-east-1a"
    }
    vpc2 = {
      cidr_block  = "10.1.0.0/16"
      subnet_cidr = "10.1.1.0/24"
      az          = "us-east-1b"
    }
    vpc3 = {
      cidr_block  = "10.2.0.0/16"
      subnet_cidr = "10.2.1.0/24"
      az          = "us-east-1c"
    }
    vpc4 = {
      cidr_block  = "10.3.0.0/16"
      subnet_cidr = "10.3.1.0/24"
      az          = "us-east-1d"
    }
  }
}

resource "aws_vpc" "this" {
  for_each = var.vpcs

  cidr_block = each.value.cidr_block

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "public" {
  for_each = var.vpcs

  vpc_id                  = aws_vpc.this[each.key].id
  cidr_block              = each.value.subnet_cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${each.key}-public-subnet"
  }
}

resource "aws_internet_gateway" "this" {
  for_each = var.vpcs

  vpc_id = aws_vpc.this[each.key].id

  tags = {
    Name = "${each.key}-igw"
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
    Name = "${each.key}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  for_each = var.vpcs

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[each.key].id
}
