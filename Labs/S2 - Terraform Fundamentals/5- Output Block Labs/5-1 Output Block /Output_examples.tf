# This lab creates an S3 bucket and an AWS VPC then uses the output block to display the ARN of the S3 bucket and the ID of the VPC


resource "aws_s3_bucket" "mys3" {
  bucket = "dolfined12345678910"
}

resource "aws_vpc" "Lab_VPC" {
  cidr_block       = "10.0.0.0/16"
}

output "s3_arn" {
  value = aws_s3_bucket.mys3.arn
}

output "VPC_id" {
  value = aws_vpc.Lab_VPC.id 
}
