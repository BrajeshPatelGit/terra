
# Requirements:
# Create an S3 bucket and assign it the tag "dolfined_bucket", use a unique name for the bucket.
# Create a new VPC in us-east-1 with the tag Name = "dolfined_VPC" with the CIDR 10.0.0.0/16 in AWS's us-east-1 region. 
# Create a subnet in the above VPC, the CIDR to use is  10.0.1.0/24 with the name Public_Subnet.
# Create an EC2 instance in the above subnet. 
# Check the console to validate the correct resources were created.
# Destroy the created resources.


# Define the provider, region and authentication profile

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

# Create the S3 bucket

resource "aws_s3_bucket" "dolfined_bucket" {
  bucket = "my-tf-test12345-bucket-12345"

}

# Create the VPC

resource "aws_vpc" "dolfined_VPC" {
  cidr_block = "10.0.0.0/16"
}

# Create the public subnet 

resource "aws_subnet" "Public_Subnet" {
  vpc_id     = aws_vpc.dolfined_VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

}

# Create an EC2 instance in the public subnet

resource "aws_instance" "myec2_Public" {
  ami           = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.Public_Subnet.id
  associate_public_ip_address = true
   
}

