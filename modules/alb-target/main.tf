variable "target_group_name" {
  type    = "list"
  default = []
}

variable "ports" {
  type    = "list"
  default = []
}

variable "vpc_id" {
  default = ""
}

variable "health_path" {
  type    = "list"
  default = []
}

variable "target_type" {
  default = ""
}

resource "aws_lb_target_group" "target" {
  count       = length(var.target_group_name)
  name        = element(var.target_group_name, count.index)
  port        = element(var.ports, count.index)
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    protocol            = "HTTP"
    healthy_threshold   = 3
    port                = element(var.ports, count.index)
    unhealthy_threshold = 5
    timeout             = 30
    path                = element(var.health_path, count.index)
    interval            = 40
  }
}

output "target_name" {
  value = "${aws_lb_target_group.target[*].name}"
}

output "target_arn" {
  value = "${aws_lb_target_group.target[*].arn}"
}
