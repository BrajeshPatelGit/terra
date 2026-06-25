
module "ec2module" {
  source       = "../modules/ec2"
  # ec2_instance = "t2.micro"
}

module "sgmodule" {
  source   = "../modules/sg"
  # db_port = "3000"
}
