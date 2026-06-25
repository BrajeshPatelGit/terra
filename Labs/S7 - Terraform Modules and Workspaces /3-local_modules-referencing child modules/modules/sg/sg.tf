## this module creates a security group that allows access from an application to the database. It allows the DB port inboud and all traffic outbound. 
# Also, it displays the security group ID after it has been created. 

output "sgid123" {
  value = aws_security_group.DBSG.id
}


resource "aws_security_group" "DBSG" {
  name = "myDB-sg"

  ingress {
    description = "Allow Inbound from My Database Application "
    from_port   = var.db_port
    to_port     = var.db_port
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

