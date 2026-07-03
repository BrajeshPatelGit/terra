# This lab demonstrates how we can use remote provisioners to excute code on an EC2 instance after creating it


provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "myec2" {
  ami                         = "ami-0d351f1b760a30161"
  associate_public_ip_address = true
  availability_zone           = "ap-south-1a"
  instance_type               = "t2.micro"
  key_name                    = "keypair-vpc1"
  vpc_security_group_ids      = ["sg-021feeb0880579ad4"]

  connection {
    type        = "ssh"      # ssh or winrm
    user        = "ec2-user" # the ssh user to use for the connection
    private_key = file("~/downloads/keypair-vpc1.pem")
    host        = self.public_ip
  }


  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras enable nginx1",
      "sudo yum clean metadata",
      "sudo yum -y install nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }

  timeouts {
    create = "10m"
  }

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

  