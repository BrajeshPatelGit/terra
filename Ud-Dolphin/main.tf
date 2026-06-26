resource "aws_vpc" "prd_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "prd-vpc"
  }
}
resource "aws_s3_bucket" "terra_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "terra_bucket_acl" {
  bucket = aws_s3_bucket.terra_bucket.id
  acl    = "private"
}