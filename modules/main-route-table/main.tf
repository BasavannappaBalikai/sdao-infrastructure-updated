variable "vpc_id" {
  default = ""
}

variable "route_table_id" {
  default = ""
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = var.vpc_id
  route_table_id = element(var.route_table_id, 0)
}
