module "sdao-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "sdao-onchain-server-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "onchain_data_server"
  branch                 = "development"
  github_oauth_token     = "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"
  codebuild_project_name = "onchain_server-dev"
  cluster_name           = "onchain-server-cluster"
  service_name           = "onchain-server-ecs-service"

}



module "sdao-dynaset-backend-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "dynaset-server-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "dynaset-backend"
  branch                 = "development"
  github_oauth_token     = "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"
  codebuild_project_name = "dynaset_backend-dev"
  cluster_name           = "dynaset-backend-dev"
  service_name           = "dynaset-backend-ecs-service"

}

module "sdao-portfolio-api-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "portfolio-api-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "portfolio_management_fastapi"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "portfolio-api-dev"
  cluster_name           = "portfolio-api-dev"
  service_name           = "portfolio-api-dev-ecs-service"

}


module "sdao-token-holder-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "token-holder-scraper-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "token-holders-data-scraper"
  branch                 = "Feature/Ethereum-Data-Scraper"
  github_oauth_token     = "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"
  codebuild_project_name = "token_holder_scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "token-holder-scraper-ecs-service"

}

module "sdao-token-holder-binance-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "token-holder-binance-scraper-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "token-holders-data-scraper"
  branch                 = "Feature/Binance-Data-Scraper"
  github_oauth_token     = "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"
  codebuild_project_name = "token_holder_binance_scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "token-holder--binance-scraper-ecs-service"

}


module "sdao-unbounded-bsc-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "unbounded-bsc-scraper-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "token-holders-data-scraper"
  branch                 = "Feature/Unbonded_BSC"
  github_oauth_token     = "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"
  codebuild_project_name = "unbounded_bsc_scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "token-holder-unbounded-bsc-ecs-service"

}


module "sdao-unbounded-erc-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "unbounded-erc-scraper-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "token-holders-data-scraper"
  branch                 = "Feature/Unbonded_ERC"
  github_oauth_token     = "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"
  codebuild_project_name = "unbounded_erc_scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "token-holder-unbounded-erc-ecs-service"

}




module "sdao-dapp-codepipeline" {
  source                 = "../../modules/launchpad-portal-codepipeline"
  name                   = "sdao-dapp-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "dapp"
  branch                 = "development"
  github_oauth_token     = "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"
  codebuild_project_name = "dapp-dev"

}


module "sdao-launchpad-api-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "launchpad-api-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "launchpad-api"
  branch                 = "development"
  github_oauth_token     = "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"
  codebuild_project_name = "launchpad-api-dev"
  cluster_name           = "launchpad-api-dev"
  service_name           = "launchpad-api-dev-ecs-service"

}

module "sdao-launchpad-api-admin-codepipeline" {
  source                 = "../../modules/launchpad-portal-codepipeline"
  name                   = "sdao-launchpad-api-admin-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "sdao-monorepo"
  branch                 = "development"
  github_oauth_token     = "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"
  codebuild_project_name = "launchpad_api_admin-dev"

}


module "sdao-launchpad-api-frontend-codepipeline" {
  source                 = "../../modules/launchpad-portal-codepipeline"
  name                   = "sdao-launchpad-api-frontend-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "sdao-monorepo"
  branch                 = "development"
  github_oauth_token     = "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"
  codebuild_project_name = "launchpad_api_frontend-dev"

}



module "sdao-lp-sdao-usdt-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "lp-sdao-usdt-scraper-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "token-holders-data-scraper"
  branch                 = "Feature/LP_SDAO_USDT"
  github_oauth_token     = "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"
  codebuild_project_name = "lp_sdao_usdt_scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "token-holders-lp-sdao-usdt-ecs-service"

}

module "sdao-lp-sdao-usd-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "lp-sdao-usd-scraper-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "token-holders-data-scraper"
  branch                 = "Feature/LP_SDAO_USD"
  github_oauth_token     = "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"
  codebuild_project_name = "lp_sdao_usd_scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "token-holder-lp-sdao-usd-ecs-service"

}

module "sdao-lp-sdao-bnb-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "lp-sdao-bnb-scraper-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "token-holders-data-scraper"
  branch                 = "Feature/LP_SDAO_BNB"
  github_oauth_token     = "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"
  codebuild_project_name = "lp_sdao_bnb_scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "token-holder-lp-sdao-bnb-ecs-service"

}


module "sdao-lp-sdao-weth-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "lp-sdao-weth-scraper-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "token-holders-data-scraper"
  branch                 = "Feature/LP_SDAO_WETH"
  github_oauth_token     = "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"
  codebuild_project_name = "lp_sdao_weth_scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "token-holder-lp-sdao-weth-ecs-service"
}

module "huginexpert-fast-api-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "huginexpert-fast-api-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "huginexpert_fastapi"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "huginexpert-fast-api-dev"
  cluster_name           = "huginexpert-fast-api-dev"
  service_name           = "huginexpert-fast-api-dev-ecs-service"

}

module "bonded-data-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "bonded-data-scraper-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "bonded_data_scraper"
  branch                 = "bnb_bonded_scraper"
  github_oauth_token     = "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"
  codebuild_project_name = "bonded-data-scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "bonded-data-scraper-ecs-service-dev"

}

module "eth_scraper_3m-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "eth-scraper-3m-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "bonded_data_scraper"
  branch                 = "eth_scraper_3m"
  github_oauth_token     = "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"
  codebuild_project_name = "eth-scraper-3m-scraper-dev"
  cluster_name           = "token-holder-scraper-dev"
  service_name           = "eth-scraper-3m-ecs-service-dev"

}

module "tradingbot-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "tradingbot-dev-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "TradingBot"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "tradingbot-dev"
  cluster_name           = "trading-bot-dev"
  service_name           = "tradingbo-ecs-service-dev"

}
