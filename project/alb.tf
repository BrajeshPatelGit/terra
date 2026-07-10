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
