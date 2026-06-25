## create_before_destroy lifecycle meta argument
## Instructs Terraform to create the replacement resource before destroying the current one


provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}


resource "aws_instance" "myec2" {
  ami           = "ami-07caf09b362be10b8"
  # ami           = "ami-022e1a32d3f742bd8"
 
  instance_type = "t2.micro"
  
    lifecycle {
    create_before_destroy = true
  }

}




