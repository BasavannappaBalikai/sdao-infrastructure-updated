variable "load_balancer_arn" {
  default = ""
}

variable "target_group_arn" {
  type    = "list"
  default = []
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = var.load_balancer_arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn[0]
  }
}

output "listener_arn" {
  value = "${aws_lb_listener.front_end.arn}"
}
