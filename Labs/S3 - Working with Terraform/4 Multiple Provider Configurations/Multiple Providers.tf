# fetching an AMI in account 1, and creating a resource in that account using the fetched AMI ID

data "aws_ami" "myami_acct1" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter { 
    name = "root-device-type" 
    values = ["ebs"]                    # ebs, instance-store
  }  

  filter {
    name   = "virtualization-type"
    values = ["hvm"]                    # hvm, paravirtual
  }     
}

resource "aws_instance" "instance-acct_1" {
 ami           = data.aws_ami.myami_acct1.id
  instance_type = "t2.micro"
}



# fetching an AMI in account 2, and creating a resource in that account using the fetched AMI ID 


data "aws_ami" "myami_acct2" {
  most_recent = true
  owners      = ["amazon"]
  # provider=aws.west             #Alias to the correct provider block

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter { 
    name = "root-device-type" 
    values = ["ebs"]                     # ebs, instance-store
  }  

  filter {
    name   = "virtualization-type"
    values = ["hvm"]                     # hvm, paravirtual
  }     
}

resource "aws_instance" "instance-acct_2" {
  # provider      = aws.west    #Alias to the correct provider block
  ami           = data.aws_ami.myami_acct2.id
  instance_type = "t2.micro"
}

