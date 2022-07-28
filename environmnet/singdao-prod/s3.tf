module "config_bucket" {
  source      = "../../modules/s3"
  bucket_name = "singdao-config-prod"
  acl         = "private"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "sdao_artifact_store" {
  source      = "../../modules/s3"
  bucket_name = "singdao-artifact-store-prod"
  acl         = "private"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "sdao_launchpad_frontend" {
  source      = "../../modules/static-hosting"
  domain_name = "launchpad.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "sdao_launchpad_admin" {
  source      = "../../modules/static-hosting"
  domain_name = "launchpad-admin.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "trading_dashboard_bucket" {
  source      = "../../modules/static-hosting"
  domain_name = "trading-dashboard.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}


module "sdao-sftp-storage" {
  source      = "../../modules/s3"
  bucket_name = "sdao-sftp-storage"
  acl         = "private"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "sdao-cryptoquant-data-store" {
  source      = "../../modules/s3"
  bucket_name = "cryptoquant-sdao-data"
  acl         = "private"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}


module "launchpad_api_test_admin" {
  source      = "../../modules/static-hosting"
  domain_name = "temp-launchpad-api-admin.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "launchpad_api_test_frontend" {
  source      = "../../modules/static-hosting"
  domain_name = "temp-launchpad-api-frontend.singularitydao.ai"
  tags = {
    Owner       = "Basavaraj"
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}
