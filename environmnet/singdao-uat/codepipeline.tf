module "sdao-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "sdao-onchain-server-pipeline-uat"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "onchain_data_server"
  branch                 = "UAT"
  codebuild_project_name = "onchain_server-uat"
  cluster_name           = "onchain-server-cluster-uat"
  service_name           = "onchain-server-ecs-service-uat"
  github_oauth_token     = "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"

}

module "sdao-dynaset-backend-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "dynaset-server-uat-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "dynaset-backend"
  branch                 = "uat"
  github_oauth_token     = "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"
  codebuild_project_name = "dynaset_backend-uat"
  cluster_name           = "dynaset-backend-uat"
  service_name           = "dynaset-backend-ecs-service-uat"

}

module "sdao-dynaset-backend-master-codepipeline" {
  source                 = "../../modules/codepipeline"
  name                   = "dynaset-server-master-uat-pipeline"
  role_arn               = "${module.code_pipeline_role.role_arn}"
  location               = "${module.sdao_artifact_store.bucket_name}"
  repository_owner       = "Singularity-DAO"
  repository_name        = "dynaset-backend"
  branch                 = "uat"
  github_oauth_token     = "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"
  codebuild_project_name = "dynaset_backend_master-uat"
  cluster_name           = "dynaset-backend-master-uat"
  service_name           = "dynaset-backend-uat-master-ecs-service"

}
