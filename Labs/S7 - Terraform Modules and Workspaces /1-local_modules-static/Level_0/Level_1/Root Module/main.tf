
module "ec2module_1" {
  source       = "../EC2_Module_1" 
}

module "ec2module_2" {
  source       = "./EC2_Module_2"
}

module "sgmodule" {
  source   = "../../Security_Modules/Sec_Grp_Module"
}

