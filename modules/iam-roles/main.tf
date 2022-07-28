variable "policy_arn" {
  default = "sinuglaritynet-cd.json"
}

variable "role_name" {
  default = "sinuglaritynet-cd"
}

variable "resource_type" {
  default = ""
}

resource "aws_iam_role" "iam_role" {
  name               = var.role_name
  assume_role_policy = file("${path.module}/templates/${var.resource_type}")
}

resource "aws_iam_role_policy_attachment" "role-policy-attach" {
  role       = "${aws_iam_role.iam_role.name}"
  policy_arn = var.policy_arn
}

output "role_arn" {
  value = "${aws_iam_role.iam_role.arn}"
}

output "role_name" {
  value = "${aws_iam_role.iam_role.name}"
}
