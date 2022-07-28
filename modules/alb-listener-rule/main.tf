variable "listener_arn" {
  default = ""
}

variable "priority" {
  type    = "list"
  default = []
}

variable "target_arn" {
  type    = "list"
  default = []
}

variable "paths" {
  type    = "list"
  default = []
}

resource "aws_lb_listener_rule" "static" {
  count        = length(var.target_arn)
  listener_arn = var.listener_arn
  priority     = element(var.priority, count.index)

  action {
    type             = "forward"
    target_group_arn = element(var.target_arn, count.index)
  }

  condition {
    path_pattern {
      values = [element(var.paths, count.index)]
    }
  }
}
