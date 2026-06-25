resource "aws_instance" "myec2_micro" {
  ami           = "ami-00beae93a2d981137"
  instance_type = "t2.micro"
}