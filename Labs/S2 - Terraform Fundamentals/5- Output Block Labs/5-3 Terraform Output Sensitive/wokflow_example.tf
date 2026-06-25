# This workflow will show the use of the sensitive option in an output block, it will also show that the sensitive arguments/output will be suppressed in the screen output, but it will be visible in the state file.

# do the lab once without the sensitive = true option, and once with it and demonstrate the difference. 

  

# resource "random_password" "pwd" {
#   length  = 16
#   special = true
# }

# output "paswd" {
#   value     = random_password.pwd.result
#   sensitive = true
# }


resource "random_string" "random" {
  length           = 16
  special          = true
}

output "sensitive_test" {
  value     = random_string.random.result
  sensitive = true
}



