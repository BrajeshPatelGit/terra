resource "aws_lb" "web_alb" {
  name               = "WebALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.alb_sg.security_group_id]
  subnets            = module.vpc.public_subnets

  tags = {
    Name = "WebALB"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group" "web_tg" {
  name        = "WebTG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "WebTG"
  }
}

resource "aws_lb_target_group_attachment" "web_serv11" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = module.web_serv11.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_serv22" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = module.web_serv22.id
  port             = 80
}
