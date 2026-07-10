output "alb_dns_name" {
  description = "DNS hostname of the Application Load Balancer"
  value       = aws_lb.web_alb.dns_name
}

output "web_serv11_id" {
  description = "Instance ID of web-serv11"
  value       = module.web_serv11.id
}

output "web_serv22_id" {
  description = "Instance ID of web-serv22"
  value       = module.web_serv22.id
}
