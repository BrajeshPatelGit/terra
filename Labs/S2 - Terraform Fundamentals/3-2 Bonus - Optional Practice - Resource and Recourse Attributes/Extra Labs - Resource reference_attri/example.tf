/*
(1) Create a VPC with the name "dolfined_VPC" and CIDR 10.0.0.0/16 in us-east-1
(2) Create an Internet gateway with the tag name "test_IGW" and attach it to the VPC above.
(3) Create a subnet with the tag name Public_Subnet and CIDR 10.0.1.0/24 in the above VPC.
(4) Create an Elastic IP
(5) Create a Nat Gateway with the tag name "NATGW"in the subnet in (3) and attach the elastic IP created in (4) to the Nat gateway.
(6) Validate using the AWS console
(7) Destroy the infrastrucuture.
*/


# Creat the VPC

resource "aws_vpc" "dolfined_VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name= "dolfined_VPC"
  }
}

# Create an Internet Gateway

resource "aws_internet_gateway" "igw" {
 # vpc_id = aws_vpc.dolfined_VPC.id

  tags = {
    Name = "test_IGW"
  }
}


#Create an IGW attachment to the VPC

resource "aws_internet_gateway_attachment" "igw-attach" {
  internet_gateway_id = aws_internet_gateway.igw.id
  vpc_id = aws_vpc.dolfined_VPC.id
}


# Create an EIP address
resource "aws_eip" "ngw_eip" {
  domain = "vpc"
}

# Create a public subnet

resource "aws_subnet" "Public_Subnet" {
  vpc_id     = aws_vpc.dolfined_VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Public_Subnet"
  }
}


# Create a NAT  gateway
resource "aws_nat_gateway" "NATGW1" {
  allocation_id = aws_eip.ngw_eip.id
  subnet_id     = aws_subnet.Public_Subnet.id

  tags = {
    Name = "NATGW"
  }
}

