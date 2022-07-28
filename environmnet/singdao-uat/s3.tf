module "config_bucket" {
  source      = "../../modules/s3"
  bucket_name = "singdao-config-uat"
  acl         = "private"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
  }
}

module "sdao_artifact_store" {
  source      = "../../modules/s3"
  bucket_name = "singdao-artifact-store-uat"
  acl         = "private"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
  }
}


module "trading_dashboard_bucket" {
  source      = "../../modules/static-hosting"
  domain_name = "uat-trading-dashboard.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
  }
}

module "sdao_ui_bucket" {
  source      = "../../modules/s3"
  bucket_name = "sdao-monorepo-cache"
  acl         = "private"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
  }
}
