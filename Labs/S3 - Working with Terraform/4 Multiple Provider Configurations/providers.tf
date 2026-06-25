
# The default provider block, Provider is aws.
# note: the Profile is dev_admin in account 1

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}


# Additional provider configuration for us-west-2 region in a completely separate AWS account;  
# resources can reference this as `aws.west`.
# note: the Profile is acct2_admin in account 2

provider "aws" {
  # alias   = "west"
  region  = "us-west-2"
  profile = "terraform_dev"
}