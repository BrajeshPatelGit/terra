terraform {
  required_version= ">1.8.0"
  required_providers {
    mycloud = {
      # version = ">= 5.0 , <= 5.6"
      version = "=4.4"
      source = "hashicorp/aws"
    }
  }

}

provider "mycloud"{
  region ="us-east-1"
  profile="dev_admin"
}
