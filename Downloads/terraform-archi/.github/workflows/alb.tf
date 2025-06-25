resource "aws_lb" "app_alb" {
  name               = "app-alb"
  load_balancer_type = "application"
  subnets            = values(aws_subnet.public)[*].id
  security_groups    = [aws_security_group.web_sg.id]

  tags = {
    Name = "app-alb"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.app_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "web_server_attach" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id         = aws_instance.web_server.id
  port              = 80
}
