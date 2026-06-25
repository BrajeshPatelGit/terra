cidr_block= "10.0.0.0/16"
  
ami_var = {
    us-east-1  = "ami-0ae8f15ae66fe8cda"
    us-west-2  = "ami-0a38c1c38a15fed74"
    ap-south-1 = "ami-0a4408457f9a03be3"
  }

instance_types = {
    us-east-1  = "t2.micro"
    us-west-2  = "t2.nano"
    ap-south-1 = "t2.small"
  }

az_var  = ["us-east-1a", "us-west-2a", "ap-south-1a"]
