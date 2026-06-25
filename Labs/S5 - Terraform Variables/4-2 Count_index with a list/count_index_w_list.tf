# using count.index to refer to list items for better naming or tagging between resources created with the count parameter

# using a list variable containing the names of the IAM users we need to create, and then using count.index to point to list items one at a time

provider "aws" {
  region  = "us-east-1"
  profile = "dev_admin"
}

variable "iam_usernames" {
  type    = list(any)
  default = ["Engineer", "Administrator", "Tester", "Developer", "Auditor"]
}

resource "aws_iam_user" "users" {
  name  = var.iam_usernames[count.index]
  count = 5
}


