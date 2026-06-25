provider "aws" {
  region = "us-east-1"
  profile = "dev_admin"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-dolfined-tf-test-bucket-12345abcd"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

