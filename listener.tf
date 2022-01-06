resource "aws_lb_target_group" "this" {
  name        = "${var.service_name}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    enabled           = true
    path              = var.health_check_path
    interval          = var.health_check_interval
    healthy_threshold = var.health_check_healthy_threshold
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = var.alb_arn

  # We let CloudFlare handle TLS which can simplify the AWS infra a bit
  port     = "80"
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
