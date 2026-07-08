variable "instance_type" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t2.large"
    sit  = "t2.medium"
    st   = "t3.medium"
  }
}
