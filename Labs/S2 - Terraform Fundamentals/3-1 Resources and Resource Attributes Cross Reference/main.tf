

/*
1) create a VPC in us-east-1, CIDR 10.0.0.0/16
2) create a subnet with the CIDR 10.0.2.0/24 into the above VPC
3) create an S3 bucket in the same region
*/


provider "aws" {
  region="us-east-1"
  profile="dev_admin"  
}

resource "aws_vpc" "Lab_VPC" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "custom_VPC"
  }
}


resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.Lab_VPC.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "First Subnet -  Public"
  }
}


resource "aws_s3_bucket" "bucket_test" {
  bucket = "dolfined-bucket-1234abcd"

  tags = {
    Name        = "My bucket 1"
  }
}


