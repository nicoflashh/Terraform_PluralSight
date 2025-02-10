output "aws_lb_public_dns" {
  value = "https://${aws_lb.nginx.dns_name}"
  description = "Public DNS for the application Load Balancer"
}