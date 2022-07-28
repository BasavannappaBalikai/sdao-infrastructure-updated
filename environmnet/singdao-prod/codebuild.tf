module "sdao-launchpad-codebuild" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["launchpad_server-prod"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-serverless"
  image_pull_credentials_type = "SERVICE_ROLE"
  config_bucket               = "singdao-config-prod"
  environment                 = "prod"
  target_bucket               = "${module.sdao_artifact_store.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "LOCAL"
  cache_modes                 = ["LOCAL_CUSTOM_CACHE", "LOCAL_SOURCE_CACHE"]
  location                    = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch                      = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "launchpad_frontend" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["launchpad_frontend-prod"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  image_pull_credentials_type = "SERVICE_ROLE"
  config_bucket               = "singdao-config-prod"
  environment                 = "prod"
  target_bucket               = "${module.sdao_launchpad_frontend.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "NO_CACHE"
  location                    = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch                      = "main"
  NODE_ENV                    = "production"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "launchpad_portal_admin" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["launchpad_admin-prod"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  image_pull_credentials_type = "SERVICE_ROLE"
  config_bucket               = "singdao-config-prod"
  environment                 = "prod"
  target_bucket               = "${module.sdao_launchpad_admin.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "LOCAL"
  cache_modes                 = ["LOCAL_CUSTOM_CACHE", "LOCAL_SOURCE_CACHE"]
  location                    = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch                      = "main"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "sdao-codebuild-projects" {
  source             = "../../modules/codebuild"
  name               = ["onchain_server-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/onchain_data_server.git"
  branch             = "master"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "trading_dashboard_app" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["trading_dashboard-prod"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  image_pull_credentials_type = "SERVICE_ROLE"
  config_bucket               = "singdao-config-prod"
  environment                 = "prod"
  target_bucket               = "${module.trading_dashboard_bucket.bucket_name}"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "S3"
  cache_location              = "monorepo-cache/trading-dashboard_prod"
  location                    = "https://github.com/Singularity-DAO/trading-dashboard-app.git"
  branch                      = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "sdao-binance-scraper" {
  source             = "../../modules/codebuild"
  name               = ["binance_scraper-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/binance_complete_scraper.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "sdao-coinbase-scraper" {
  source             = "../../modules/codebuild"
  name               = ["coinbase_scraper-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/coinbase_complete_scraper.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "sdao-deribit-scraper" {
  source             = "../../modules/codebuild"
  name               = ["deribit_scraper-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/deribit_scraper_complete.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "sdao-kucoin-scraper" {
  source             = "../../modules/codebuild"
  name               = ["kucoin_scraper-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/kucoin_complete_scraper.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "sdao-exchange-data-scraper" {
  source             = "../../modules/codebuild"
  name               = ["exchange_data_scraper-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/exchange_data_scraper.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "sdao-binance-v2-scraper" {
  source             = "../../modules/codebuild"
  name               = ["binance_scraper_v2-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/binance_complete_scraper.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "dynaset-backend" {
  source             = "../../modules/codebuild"
  name               = ["dynaset_backend-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/dynaset-backend.git"
  branch             = "master"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "sdao-dapp-codebuild" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["dapp-prod"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-serverless"
  config_bucket               = "singdao-config-prod"
  environment                 = "prod"
  target_bucket               = "${module.sdao_artifact_store.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  image_pull_credentials_type = "SERVICE_ROLE"
  cache_type                  = "NO_CACHE"
  location                    = "https://github.com/Singularity-DAO/dapp.git"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  branch                      = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "docker-build" {
  source             = "../../modules/codebuild"
  name               = ["docker-build-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/launchpad-api.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "launchpad-api-codebuild" {
  source             = "../../modules/codebuild"
  name               = ["launchpad-api-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/launchpad-api.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "launchpad_api_portal_temp_admin" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["launchpad_api_temp_admin-prod"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  image_pull_credentials_type = "SERVICE_ROLE"
  config_bucket               = "singdao-config-prod"
  environment                 = "prod"
  target_bucket               = "${module.launchpad_api_test_admin.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "NO_CACHE"
  location                    = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch                      = "main"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "launchpad_api_portal_temp_frontend" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["launchpad_api_temp_frontend-prod"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  image_pull_credentials_type = "SERVICE_ROLE"
  config_bucket               = "singdao-config-prod"
  environment                 = "prod"
  target_bucket               = "${module.launchpad_api_test_frontend.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "NO_CACHE"
  location                    = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch                      = "main"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}



module "msd-api-codebuild" {
  source             = "../../modules/codebuild"
  name               = ["msd-api-prod"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "prod"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/niox-ai.git"
  branch             = "master"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}
