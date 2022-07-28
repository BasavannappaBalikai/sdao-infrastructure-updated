variable "role_arn" {
  default = ""
}
variable "tags" {
  default = ""
}
resource "aws_transfer_server" "sdao_sftp_server" {
  identity_provider_type = "API_GATEWAY"
  logging_role           = var.role_arn
  tags                   = var.tags
  lifecycle {
    ignore_changes = [
      force_destroy,
      invocation_role,
      logging_role,
      tags,
      url
    ]
  }
}

