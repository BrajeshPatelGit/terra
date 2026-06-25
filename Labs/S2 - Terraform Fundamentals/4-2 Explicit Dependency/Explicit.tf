################## Explicit Dependancy############################
## Demo to show that if the depends_on argument does not exist, the two resources EC2 and S3 bucket will be created in parallel. 
## If we add the depends_on statement, you will see that S3 starts and completes before the EC2 instance creation starts.

  

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

resource "aws_instance" "example_ec2" {
  ami           = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
  # depends_on = [aws_s3_bucket.example]
  # the instance needs to upload statup logs to the bucket

}

resource "aws_s3_bucket" "example" {
  bucket = "dolfined123456789"
}



