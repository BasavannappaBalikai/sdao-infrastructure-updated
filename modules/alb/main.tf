variable "name" {
  default = ""
}

variable "sg_id" {
  default = ""
}

variable "public_subnets" {
  type    = list
  default = []
}

resource "aws_lb" "application_lb" {
  name                       = var.name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.sg_id]
  subnets                    = var.public_subnets
  enable_deletion_protection = true
}

output "alb_arn" {
  value = "${aws_lb.application_lb.arn}"
}
