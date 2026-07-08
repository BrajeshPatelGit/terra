# This lab demonstrates how we can use remote provisioners to excute code on an EC2 instance after creating it


resource "aws_instance" "myec2" {
  ami                         = "ami-0d351f1b760a30161"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = "keypair-vpc1"
  availability_zone           = "ap-south-1a"
  associate_public_ip_address = true

  tags = {
    Name = "main-ec2"
  }

  # depends_on = [aws_vpc.main, aws_security_group.main]
}

output "instance_DNS" {
  value = aws_instance.myec2.public_dns
}


# you can pass the user data script to remote exec using
#   provisioner "remote-exec" {
#   # script = "${path.module}/script.sh"
#     script = "./script.sh"
#  }


# you can use the following to pass the user date instead of exec-provisioner
# user_data = file("${path.module}/script.sh")

  