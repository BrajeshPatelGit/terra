# This demo demonstrates the local-exec provisioner in Terraform.
# It creates an instance then reads the private IP and save it in a text file.


# Create ec2 instance

resource "aws_instance" "myec2" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"

  provisioner "local-exec" {
      command = "echo ${aws_instance.myec2.private_ip} >> private_ips.txt"
  }
}












# It also demonstrates the destroy time provisioner action 

# resource "aws_iam_user" "app_admin" {
#   name = "administrator"
#   provisioner "local-exec" {
#         command = "echo ${aws_instance.myec2.private_ip} >> private_ips.txt"

#         # command = "echo ${self.private_ip} >> private_ips.txt"
        
#         # command = " echo 'my instance is being destroyed.' "
#         # when    = destroy
#         # on_failure = continue

#         # on_failure = continue

#   }
# }
