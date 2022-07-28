variable "reply_to_email_address" {
  default = ""
}

module "userpool" {
  source                 = "../../modules/cognito-userpool"
  name                   = "singdao_dev"
  reply_to_email_address = var.reply_to_email_address
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}

module "userpool-client" {
  source       = "../../modules/cognito-client"
  name         = "singdao_dev"
  user_pool_id = "${module.userpool.user_pool_id}"
}
