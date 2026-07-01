resource_names = {
  vpc1 = {
    vpc_name              = "dev-vpc-1"
    subnet_name           = "dev-vpc-1-public-subnet"
    internet_gateway_name = "dev-vpc-1-igw"
    route_table_name      = "dev-vpc-1-public-rt"
  }
  vpc2 = {
    vpc_name              = "qa-vpc-2"
    subnet_name           = "qa-vpc-2-public-subnet"
    internet_gateway_name = "qa-vpc-2-igw"
    route_table_name      = "qa-vpc-2-public-rt"
  }
  vpc3 = {
    vpc_name              = "shrd-vpc-3"
    subnet_name           = "shrd-vpc-3-public-subnet"
    internet_gateway_name = "shrd-vpc-3-igw"
    route_table_name      = "shrd-vpc-3-public-rt"
  }
  vpc4 = {
    vpc_name              = "cadev-vpc"
    subnet_name           = "cadev-vpc-public-subnet"
    internet_gateway_name = "cadev-vpc-igw"
    route_table_name      = "cadev-vpc-public-rt"
  }
}

# Edit these values to match your AWS environment.
instance_ami_ids = {
  vpc1 = "ami-040875d8447f6c9c0"
  vpc2 = "ami-040875d8447f6c9c0"
  vpc3 = "ami-040875d8447f6c9c0"
  vpc4 = "ami-040875d8447f6c9c0"
}

instance_key_pairs = {
  vpc1 = "keypair-vpc1"
  vpc2 = "keypair-vpc2"
  vpc3 = "keypair-vpc3"
  vpc4 = "keypair-vpc4"
}
