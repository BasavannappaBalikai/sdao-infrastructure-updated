variable "reply_to_email_address" {
  default = ""
}

module "userpool" {
  source                 = "../../modules/cognito-userpool"
  name                   = "singdao_uat"
  reply_to_email_address = var.reply_to_email_address
  #source_arn             = "arn:aws:ses:eu-west-1:925884611165:identity/no-reply@singularitydao.ai"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
  }
}

module "userpool-client" {
  source       = "../../modules/cognito-client"
  name         = "trading-dashboard-uat"
  user_pool_id = "${module.userpool.user_pool_id}"
}
