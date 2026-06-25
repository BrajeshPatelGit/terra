resource "aws_vpc" "newvpc" {
  cidr_block = "10.0.0.0/16"
}

output "vpcid123" {
  value = aws_vpc.newvpc.id
}
