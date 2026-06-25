## this module creates a security group that allows access from an application to the database. It allows the DB port inboud and all traffic outbound. 
# Also, it displays the security group ID after it has been created. 

output "Sec_Grp_id" {
  value = aws_security_group.AppSG.id
}


resource "aws_security_group" "AppSG" {
  name = "myApp-sg"

  ingress {
    description = "Allow Inbound to  My Application "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

