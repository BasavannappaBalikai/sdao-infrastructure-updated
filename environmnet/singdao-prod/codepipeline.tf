module "sdao-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "sdao-onchain-server-pipeline-prod"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "onchain_data_server"
  branch                 = "master"
  codebuild_project_name = "onchain_server-prod"
  cluster_name           = "onchain-server-cluster-prod"
  service_name           = "onchain-server-ecs-service-prod"
  github_oauth_token     = "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"

}

/*module "launchpad-backend-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "launchpad-backend-pipeline-prod"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "launchpad-backend"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "launchpad_server-dev"
  cluster_name           = "launchpad-server-cluster"
  service_name           = "launchpad-server-ecs-service"
}

module "launchpad-frontend-codepipeline" {
  source                 = "../../modules/launchpad-portal-codepipeline"
  name                   = "launchpad-frontend-pipeline-prod"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "launchpad-frontend"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "launchpad_frontend-dev"
}

module "launchpad-admin-codepipeline" {
  source                 = "../../modules/launchpad-portal-codepipeline"
  name                   = "launchpad-admin-pipeline-prod"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "launchpad-admin"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "launchpad_admin-dev"
}
*/


module "sdao-binance-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "binance-scraper-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "binance_complete_scraper"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "binance_scraper-prod"
  cluster_name           = "sdao-scrapers-cluster"
  service_name           = "binance-scraper-ecs-service"

}


module "sdao-coinbase-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "coinbase-scraper-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "coinbase_complete_scraper"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "coinbase_scraper-prod"
  cluster_name           = "sdao-scrapers-cluster"
  service_name           = "coinbase-scraper-ecs-service"

}


module "sdao-deribit-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "deribit-scraper-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "deribit_scraper_complete"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "deribit_scraper-prod"
  cluster_name           = "sdao-scrapers-cluster"
  service_name           = "deribit-scraper-ecs-service"

}


module "sdao-kucoin-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "kucoin-scraper-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "kucoin_complete_scraper"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "kucoin_scraper-prod"
  cluster_name           = "sdao-scrapers-cluster"
  service_name           = "kucoin-scraper-ecs-service"

}

module "sdao-exchange-data-scraper-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "exchange-data-scraper-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "exchange_data_scraper"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "exchange_data_scraper-prod"
  cluster_name           = "sdao-scrapers-cluster"
  service_name           = "exchange-data-scraper-ecs-service"

}

module "sdao-binance-scraper-v2-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "binance-scraper-v2-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "binance_complete_scraper"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "binance_scraper_v2-prod"
  cluster_name           = "sdao-scrapers-cluster"
  service_name           = "binance-scraper-v2-ecs-service"

}
module "sdao-dynaset-backend-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "dynaset-server-prod-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "dynaset-backend"
  branch                 = "master"
  github_oauth_token     = "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"
  codebuild_project_name = "dynaset_backend-prod"
  cluster_name           = "dynaset-backend-prod"
  service_name           = "dynaset-backend-ecs-service-prod"

}

module "sdao-dapp-codepipeline" {
  source                 = "../../modules/launchpad-portal-codepipeline"
  name                   = "sdao-dapp-prod-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "dapp"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "dapp-prod"

}

module "sdao-launchpad-api-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "launchpad-api-prod-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "launchpad-api"
  branch                 = "main"
  github_oauth_token     = "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"
  codebuild_project_name = "launchpad-api-prod"
  cluster_name           = "launchpad-api-prod"
  service_name           = "launchpad-api-prod-ecs-service"

}

module "msd-api-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "msd-api-prod-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "niox-ai"
  branch                 = "master"
  github_oauth_token     = "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"
  codebuild_project_name = "msd-api-prod"
  cluster_name           = "msd-api-prod"
  service_name           = "msd-api-prod-ecs-service"

}
