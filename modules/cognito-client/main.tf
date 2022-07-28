variable "name" {
  default = ""
}

variable "user_pool_id" {
  default = ""
}

resource "aws_cognito_user_pool_client" "client" {
  name                          = var.name
  user_pool_id                  = var.user_pool_id
  generate_secret               = false
  explicit_auth_flows           = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH", ]
  refresh_token_validity        = 30
  prevent_user_existence_errors = "ENABLED"

  read_attributes = [
    "address",
    "birthdate",
    "custom:first_name",
    "custom:last_name",
    "email",
    "email_verified",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "phone_number_verified",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]
  supported_identity_providers = ["COGNITO"]
  write_attributes = [
    "address",
    "birthdate",
    "custom:first_name",
    "custom:last_name",
    "email",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]


  lifecycle {
    ignore_changes = [
      explicit_auth_flows,
      refresh_token_validity
    ]
  }
}

output "client_id" {
  value = "${aws_cognito_user_pool_client.client.id}"
}
