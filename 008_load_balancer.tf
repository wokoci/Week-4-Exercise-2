
# app target group
resource "aws_lb_target_group" "app_tg" {
  name        = "jeff-app-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.jeff_vpc.id

  health_check {
    path                = "/"
    healthy_threshold   = 5
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 2
    port                = "traffic-port"
    matcher             = "200,301,302"
  }
  tags = {
    name = "jeff-app Target group"
  }
}


resource "aws_lb_listener" "jeff-http_listener" {
  port              = 80
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.jeff-app_load_balancer.arn
  default_action {
    type = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "jeff_https_listener" {
  load_balancer_arn = aws_lb.jeff-app_load_balancer.arn
  port            = 443
  protocol        = "HTTPS"
  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate.jeff_cert_tf.arn
  default_action {
   type = "forward"
   target_group_arn = aws_lb_target_group.app_tg.arn
  }
}


# application load balancer
resource "aws_lb" "jeff-app_load_balancer" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_LB_SG.id]
  subnets            = [aws_subnet.jeff_load_balancer_subnet1.id, aws_subnet.jeff_load_balancer_subnet2.id]
  lifecycle {
    create_before_destroy = false
  }
  tags = {
    name = "jeff-Application load balancer"
  }
}
