module "config_bucket" {
  source      = "../../modules/s3"
  bucket_name = "singdao-config-dev"
  acl         = "private"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}


module "sdao_artifact_store" {
  source      = "../../modules/s3"
  bucket_name = "singdao-artifact-store-dev"
  acl         = "private"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}

module "sdao_launchpad_frontend" {
  source      = "../../modules/static-hosting"
  domain_name = "dev-launchpad.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}


module "launchpad_admin" {
  source      = "../../modules/static-hosting"
  domain_name = "dev-launchpad-admin.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}

module "trading_dashboard_bucket" {
  source      = "../../modules/static-hosting"
  domain_name = "dev-trading-dashboard.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}

module "launchpad_api_admin" {
  source      = "../../modules/static-hosting"
  domain_name = "dev-launchpad-api-admin.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}

module "launchpad_api_frontend" {
  source      = "../../modules/static-hosting"
  domain_name = "dev-launchpad-api-frontend.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}
