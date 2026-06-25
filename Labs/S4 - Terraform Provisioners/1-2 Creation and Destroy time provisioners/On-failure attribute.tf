# This demo demonstrates the error behavior in terraform provisioners and how we can use the on_failure argument to change the default behavior
# It also demonstrates the creation time and destroy time provisioner action 


# Create ec2 instance

resource "aws_instance" "myec2" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
    # command = "ec01 ${self.private_ip} >> private_ips.txt"

    # on_failure = continue

  }

  #   provisioner "local-exec" {
  #   command = " echo 'my instance is being destroyed.' "
  #   # when    = destroy
  # }
}


##### When = destroy argument with terraform provisioners  #####

# Create ec2 instance

# resource "aws_instance" "myec2" {
#   ami           = "ami-022e1a32d3f742bd8"
#   instance_type = "t2.micro"

#   provisioner "local-exec" {
#     command = " echo 'my instance is being destroyed.' "
#     when    = destroy
#   }
# }














