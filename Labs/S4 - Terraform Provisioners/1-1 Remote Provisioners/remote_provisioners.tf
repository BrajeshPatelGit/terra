# This lab demonstrates how we can use remote provisioners to excute code on an EC2 instance after creating it


provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

resource "aws_instance" "myec2" {
  ami           = "ami-022e1a32d3f742bd8"
  associate_public_ip_address = true
  availability_zone = "us-east-1c"
  instance_type = "t2.micro"
  key_name      = "terraform_key"
  vpc_security_group_ids = ["sg-0258d569e0ed3731a"]
  
  connection {
    type        = "ssh"       # ssh or winrm
    user        = "ec2-user"  # the ssh user to use for the connection
    private_key = file("~/downloads/terraform_key.pem")
    host        = self.public_ip
  }


  provisioner "remote-exec" {
    inline = [
     "sudo yum -y install nginx",
     "sudo systemctl start nginx"
    ]
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

  