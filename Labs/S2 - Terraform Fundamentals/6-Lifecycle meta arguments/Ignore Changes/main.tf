## To test the ignore_changes lifecycle meta argument. Create an EC2 instance. Once created, manually on AWS console add a new tag. The normal behavior in a plan or apply step is that Terraform will detect the drift, and will reverse it in the next apply. 
## Do not apply. Un-comment the lifecycle meta argument configuration block, save the file, and do a terraform plan again. 
# Terraform will ignore the drift since it has to do with tags. 
# You can also add other things to the ignore_changes for example 

  # lifecycle {
  #   ignore_changes = [
  #     # Ignore changes to tags, instance_type 
  #     tags,instace_type, 
  #   ]
  # }

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}


resource "aws_instance" "myec2" {
  ami           = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
    
  tags = {
    Name = "lifecyclemeta_demo"
  }

  lifecycle {
    ignore_changes = [tags]
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      
  }

}




