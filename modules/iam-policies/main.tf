variable "policy_name" {
  default = ""
}

data "template_file" "policy" {
  template = "${file("${path.module}/templates/${var.policy_name}")}"
}



resource "aws_iam_policy" "iam_policy" {
  name   = var.policy_name
  path   = "/"
  policy = data.template_file.policy.rendered
}

output "policy_arn" {
  value = "${aws_iam_policy.iam_policy.arn}"
}

output "policy_name" {
  value = "${aws_iam_policy.iam_policy.name}"
}
