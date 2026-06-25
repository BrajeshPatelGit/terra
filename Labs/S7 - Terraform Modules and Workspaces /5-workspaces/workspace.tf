## this lab demonstrates the workspace feature of Terraform


resource "aws_instance" "myec2" {
  ami           = "ami-00beae93a2d981137"
  instance_type = lookup(var.instance_type, terraform.workspace)
  tags = {
    Name = lookup(var.tag_name, terraform.workspace)
  }
}

variable "instance_type" {
  type = map(any)
  default = {
    default = "t2.micro"
    prod    = "t2.large"
    dev     = "t2.medium"
    staging = "t3.medium"
  }
}

variable "tag_name" {
  type = map(any)
  default = {
    default = "default_instance"
    prod    = "prod_instance"
    dev     = "dev_instance"
    staging = "staging_instance"
  }
}
