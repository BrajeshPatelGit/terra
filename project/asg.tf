resource "aws_launch_template" "web_lt" {
  name          = "WebLT"
  image_id      = "ami-01a18c38ece67e620"
  instance_type = "t2.micro"
  key_name      = "keypair-vpc1"

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_ssm.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [module.web_sg.security_group_id]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl start httpd
    systemctl enable httpd
    echo " This is an app server in AWS Region AP-SOUTH-1 " > /var/www/html/index.html
  EOF
  )

  tags = {
    Name = "WebLT"
  }
}

resource "aws_autoscaling_group" "asg" {
  name                = "ASG"
  desired_capacity    = 2
  min_size            = 1
  max_size            = 4
  vpc_zone_identifier = module.vpc.public_subnets

  target_group_arns         = [aws_lb_target_group.web_tg.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ASG"
    propagate_at_launch = true
  }
}
