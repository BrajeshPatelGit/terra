## this module creates a security group that allows access from an application to the database. It allows the DB port inboud and all traffic outbound. 
# Also, it displays the security group ID after it has been created. 


######## ( 1 ) ######## With variables

#### demonstrate that input variable values  in the main configuration file will override the values in the child module variables. 


variable "db_port" {
  default = "1403"
}

variable "cidr" {
  type = list(any)
  default = ["0.0.0.0/0"]
}

resource "aws_security_group" "DBSG" {
  name = "myDB-sg"

  ingress {
    description = "Allow Inbound from the Application to the DB "
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }
}



######## ( 2 ) ######## With Locals

# locals {
#   db_port = "6000"
#  }

# resource "aws_security_group" "DBSG" {
#   name = "myDB-sg"

#   ingress {
#     description = "Allow Inbound from My Database Application "
#     from_port   = local.db_port
#     to_port     = local.db_port
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }



