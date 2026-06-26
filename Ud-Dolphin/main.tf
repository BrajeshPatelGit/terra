resource "aws_vpc" "prd_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "prd-vpc"
  }
}
resource "aws_s3_bucket" "terra_bucket" {
  bucket = var.s3_bucket_name
  acl    = "private"

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }
}