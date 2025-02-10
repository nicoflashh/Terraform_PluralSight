# aws_lb
resource "aws_lb" "nginx" {
  name               = "globo-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB_SG.id]
  subnets            = [aws_subnet.terraform_PrivateSubnet.id, aws_subnet.terraform_PublicSubnet.id]

  enable_deletion_protection = false

  
  tags = local.common_tags
  
}
#aws_lb_target_group
resource "aws_lb_target_group" "nginx_TG" {
  name     = "globo-ALB-Target-Group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform_VPC.id
  tags = local.common_tags
}


# aws_lb_listener
resource "aws_lb_listener" "nginx" {
    load_balancer_arn = aws_lb.nginx.arn
    port = "80"
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.nginx_TG.id
    }
    tags = local.common_tags
  
}

#aws_lb_target_group_attachment
resource "aws_lb_target_group_attachment" "nginx_Private" {
  target_group_arn = aws_lb_target_group.nginx_TG.arn
  target_id = aws_instance.nginx_EC2_TF_Private.id
  port = 80
}

resource "aws_lb_target_group_attachment" "nginx_Public" {
  target_group_arn = aws_lb_target_group.nginx_TG.arn
  target_id = aws_instance.nginx_EC2_TF_Public.id
  port = 80
}
