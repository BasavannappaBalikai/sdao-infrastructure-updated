variable "vpc_id" {
  default = ""
}

variable "sg_name" {
  default = ""
}

variable "security_ports" {
  type        = list
  description = "Get the list of security group ports"
  default     = [""]
}

variable "cidr_blocks" {
  type        = list
  description = "Get the list of CIDR Blocks"
  default     = [""]
}

variable "tags" {
  default = {}
}


resource "aws_security_group" "default" {
  name        = var.sg_name
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group_rule" "rule" {
  count = length(var.security_ports)

  #count             = 1
  type              = "ingress"
  from_port         = element(var.security_ports, count.index)
  to_port           = element(var.security_ports, count.index)
  protocol          = "TCP"
  cidr_blocks       = [element(var.cidr_blocks, count.index)]
  security_group_id = aws_security_group.default.id
}

output "sg_id" {
  value = aws_security_group.default.id
}
