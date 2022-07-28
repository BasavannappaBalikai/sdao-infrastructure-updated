variable "role_name" {
  default = ""
}

resource "aws_iam_instance_profile" "test_profile" {
  name = var.role_name
  role = var.role_name
}

output "iam_instance_profile" {
  value = "${aws_iam_instance_profile.test_profile.name}"
}
