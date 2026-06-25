##Prevent destroy lifecycle meta-argument
/*  create the instance with the lifecycle configuration part commented. 
Do a terraform plan -destroy to see what will be destroyed if you apply the commant "terraform destroy", you will find that the instance will be destroyed.

Now, uncomment the lifecycle configuration. Save the file and try again the "terraform plan -destroy"
You will get an error.

Comment the lifecycle again, save the file, and do a terraform destroy to remove the EC2 instance
*/

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}


resource "aws_instance" "myec2_Public" {
  ami           = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
    
  #  lifecycle {
  #   prevent_destroy = true
  # }

}





