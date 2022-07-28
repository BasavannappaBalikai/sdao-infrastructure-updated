variable "load_balancer_arn" {
  default = ""
}

variable "certificate_arn" {
  default = ""
}

variable "target_group_arn" {
  type    = "list"
  default = []
}


resource "aws_lb_listener" "ssl" {
  load_balancer_arn = var.load_balancer_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn[0]
  }

}

output "listener_arn" {
  value = "${aws_lb_listener.ssl.arn}"
}
