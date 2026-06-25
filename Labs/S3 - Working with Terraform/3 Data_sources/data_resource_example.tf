# This example retrieves the current region and the list of available availablity zones in that region. 
# It also fetches the most recent AWS AMI in that region


#Retrieve the list of AZs & the current AWS region & and the latest AMI ID

data "aws_region" "current" {}

output "current_region" {
  value = data.aws_region.current.id
}


# all enabled regions that are available to the account
# not the "s" in regions

data "aws_regions" "current_regions" {}

output "current_regions" {
  value = data.aws_regions.current_regions.names
}


data "aws_availability_zones" "available" {}

output "available_zones" {
  value = data.aws_availability_zones.available.names[*]
}


# Fetch the latest Amazon HVM AMI and use it to launch an EC2 instance

data "aws_ami" "myami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
    # for Amazon Linux 2023 - the name starts with al2023-ami-2023*
  }

  filter { 
    name = "root-device-type" 
    values = ["ebs"]                    # ebs, instance-store
  }  

  filter {
    name   = "virtualization-type"
    values = ["hvm"]                  # hvm, paravirtual
  }     
}


# Include the name and ID of the AMI in the output

output "fetched_ami" {
  value = data.aws_ami.myami.id
}

output "fetched_ami_name" {
  value = data.aws_ami.myami.name
}
 
# We can use the fetched AMI ID to launch an EC2 instance. 

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.myami.id
  instance_type = "t2.micro"
}


