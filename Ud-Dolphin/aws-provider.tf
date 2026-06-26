provider "aws" {
  region  = var.region
  profile = var.profile
}

# Provider is configured above. VPC resource moved to main.tf