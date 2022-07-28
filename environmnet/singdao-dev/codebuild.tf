module "sdao-codebuild-projects" {
  source             = "../../modules/codebuild"
  name               = ["onchain_server-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "sdao-launchpad-codebuild" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["launchpad_server-dev"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-serverless"
  config_bucket               = "singdao-config-dev"
  image_pull_credentials_type = "SERVICE_ROLE"
  environment                 = "dev"
  target_bucket               = "${module.sdao_artifact_store.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "NO_CACHE"
  location                    = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch                      = "development"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "launchpad_frontend" {
  source             = "../../modules/codebuild-launchpad"
  name               = ["launchpad_frontend-dev"]
  image_name         = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  config_bucket      = "singdao-config-dev"
  environment        = "dev"
  target_bucket      = "${module.sdao_launchpad_frontend.bucket_name}"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch             = "development"
  NODE_OPTIONS       = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "launchpad_portal_admin" {
  source             = "../../modules/codebuild-launchpad"
  name               = ["launchpad_admin-dev"]
  image_name         = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  config_bucket      = "singdao-config-dev"
  environment        = "dev"
  target_bucket      = "${module.launchpad_admin.bucket_name}"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch             = "main"
  NODE_OPTIONS       = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "trading_dashboard" {
  source             = "../../modules/codebuild-launchpad"
  name               = ["trading_dashboard-dev"]
  image_name         = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  config_bucket      = "singdao-config-dev"
  environment        = "dev"
  target_bucket      = "${module.trading_dashboard_bucket.bucket_name}"
  NODE_OPTIONS       = "--max-old-space-size=4096"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}



module "sdao-dapp-codebuild" {
  source             = "../../modules/codebuild-launchpad"
  name               = ["dapp-dev"]
  image_name         = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-serverless"
  config_bucket      = "singdao-config-dev"
  environment        = "dev"
  target_bucket      = "${module.sdao_artifact_store.bucket_name}"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/dapp.git"
  NODE_OPTIONS       = "--max-old-space-size=4096"
  branch             = "development"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "dynaset-backend" {
  source             = "../../modules/codebuild"
  name               = ["dynaset_backend-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/dynaset-backend.git"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}



module "portfolio-api" {
  source             = "../../modules/codebuild"
  name               = ["portfolio-api-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/portfolio_management_fastapi.git"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}



module "sdao-dapp-mainnet-2-codebuild" {
  source             = "../../modules/codebuild-launchpad"
  name               = ["dapp-mainnet1-dev"]
  image_name         = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-serverless"
  config_bucket      = "singdao-config-dev"
  environment        = "dev"
  target_bucket      = "${module.sdao_artifact_store.bucket_name}"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/dapp-mainnet.git"
  NODE_OPTIONS       = "--max-old-space-size=4096"
  branch             = "cicd-dapp-mainnet"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}



module "docker-build" {
  source             = "../../modules/codebuild"
  name               = ["docker-build-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  cache_type         = "NO_CACHE"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/TradingBot.git"
  branch             = "fix-docker-cicd"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "docker-build-2" {
  source             = "../../modules/codebuild"
  name               = ["docker-build-2-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  cache_type         = "NO_CACHE"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/bonded_data_scraper.git"
  branch             = "eth_scraper_6m"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}



module "sdao-token-holder-scraper" {
  source             = "../../modules/codebuild"
  name               = ["token_holder_scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/token-holders-data-scraper.git"
  branch             = "Feature/Ethereum-Data-Scraper"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "sdao-token-holder-binance-scraper" {
  source             = "../../modules/codebuild"
  name               = ["token_holder_binance_scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/token-holders-data-scraper.git"
  branch             = "Feature/Binance-Data-Scraper"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "sdao-unbounded-bsc-scraper" {
  source             = "../../modules/codebuild"
  name               = ["unbounded_bsc_scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/token-holders-data-scraper.git"
  branch             = "Feature/Unbonded_BSC"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "sdao-unbounded-erc-scraper" {
  source             = "../../modules/codebuild"
  name               = ["unbounded_erc_scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/token-holders-data-scraper.git"
  branch             = "Feature/Unbonded_ERC"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "launchpad-api-codebuild" {
  source             = "../../modules/codebuild"
  name               = ["launchpad-api-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/launchpad-api.git"
  branch             = "development"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "launchpad_api_portal_admin" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["launchpad_api_admin-dev"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  image_pull_credentials_type = "SERVICE_ROLE"
  config_bucket               = "singdao-config-dev"
  environment                 = "dev"
  target_bucket               = "${module.launchpad_api_admin.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "NO_CACHE"
  location                    = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch                      = "development"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "launchpad_api_portal_frontend" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["launchpad_api_frontend-dev"]
  image_name                  = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  image_pull_credentials_type = "SERVICE_ROLE"
  config_bucket               = "singdao-config-dev"
  environment                 = "dev"
  target_bucket               = "${module.launchpad_api_frontend.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "NO_CACHE"
  location                    = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch                      = "development"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}






module "sdao-lp-sdao-usdt-scraper" {
  source             = "../../modules/codebuild"
  name               = ["lp_sdao_usdt_scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/token-holders-data-scraper.git"
  branch             = "Feature/LP_SDAO_USDT"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "sdao-lp-sdao-usd-scraper" {
  source             = "../../modules/codebuild"
  name               = ["lp_sdao_usd_scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/token-holders-data-scraper.git"
  branch             = "Feature/LP_SDAO_USD"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "sdao-lp-sdao-bnb-scraper" {
  source             = "../../modules/codebuild"
  name               = ["lp_sdao_bnb_scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/token-holders-data-scraper.git"
  branch             = "Feature/LP_SDAO_BNB"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "sdao-lp-sdao-weth-scraper" {
  source             = "../../modules/codebuild"
  name               = ["lp_sdao_weth_scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  location           = "https://github.com/Singularity-DAO/token-holders-data-scraper.git"
  branch             = "Feature/LP_SDAO_WETH"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "huginexpert-fast-api-dev" {
  source             = "../../modules/codebuild"
  name               = ["huginexpert-fast-api-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/huginexpert_fastapi.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "bonded-data-scraper-dev" {
  source             = "../../modules/codebuild"
  name               = ["bonded-data-scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/bonded_data_scraper.git"
  branch             = "bnb_bonded_scraper"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "eth-scraper-3m-scraper-dev" {
  source             = "../../modules/codebuild"
  name               = ["eth-scraper-3m-scraper-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/bonded_data_scraper.git"
  branch             = "eth_scraper_3m"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "apeswap-dependencey" {
  source             = "../../modules/codebuild"
  name               = ["apeswap-dependeny"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/ApeSwapFinance/apeswap-sdk.git"
  branch             = "main"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "tradingbot-dev" {
  source             = "../../modules/codebuild"
  name               = ["tradingbot-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/TradingBot.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "yield-server-dev" {
  source             = "../../modules/codebuild"
  name               = ["yield-server-dev"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "dev"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/yield-server.git"
  branch             = "cicd-yield-server"
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}
