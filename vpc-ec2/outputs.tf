output "vpc_id" {
  value = module.vpc.vpc_id
}

output "instance_public_ip" {
  value = aws_instance.main.public_ip
}

output "instance_public_dns" {
  value = aws_instance.main.public_dns
}
