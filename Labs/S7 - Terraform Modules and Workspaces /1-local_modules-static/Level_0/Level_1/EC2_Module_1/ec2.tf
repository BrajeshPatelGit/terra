
resource "aws_instance" "myec2_nano" {
  ami           = "ami-00beae93a2d981137"
  instance_type = "t2.nano"
}


