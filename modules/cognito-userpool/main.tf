variable "name" {
  default = ""
}

variable "reply_to_email_address" {
  default = ""
}

variable "tags" {
  default = ""
}

/*variable "source_arn" {
  default = ""
}*/

resource "aws_cognito_user_pool" "pool" {
  name                       = var.name
  email_verification_subject = "Device Verification Code"
  email_verification_message = "Please use the following code {####}"
  sms_verification_message   = "{####} Baz"
  username_attributes        = ["email"]
  auto_verified_attributes   = ["email"]
  mfa_configuration          = "OPTIONAL"
  sms_authentication_message = "{####} Baz"
  software_token_mfa_configuration {
    enabled = true
  }


  username_configuration {
    case_sensitive = false
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
  }

  email_configuration {
    reply_to_email_address = var.reply_to_email_address
    email_sending_account  = "COGNITO_DEFAULT"
    #source_arn             = var.source_arn
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = false
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 5
      max_length = 80
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "phone_number"
    required                 = true

    string_attribute_constraints {
      min_length = 7
      max_length = 25
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "first_name"
    required                 = false

    string_attribute_constraints {
      min_length = 1
      max_length = 255
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "last_name"
    required                 = false

    string_attribute_constraints {
      min_length = 1
      max_length = 255
    }
  }

  tags = var.tags
}


output "user_pool_id" {
  value = "${aws_cognito_user_pool.pool.id}"
}

output "user_pool_endpoint" {
  value = "${aws_cognito_user_pool.pool.endpoint}"
}
