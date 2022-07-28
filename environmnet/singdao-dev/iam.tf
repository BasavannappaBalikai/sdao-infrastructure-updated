module "bastion_policy" {
  source      = "../../modules/iam-policies"
  policy_name = "bastion-policy-dev"
}
module "bastion_role" {
  source        = "../../modules/iam-roles"
  role_name     = "bastion-role-dev"
  resource_type = "ec2"
  policy_arn    = "${module.bastion_policy.policy_arn}"
}

module "bastion_instance_profile" {
  source    = "../../modules/instance-profile"
  role_name = "bastion-role-dev"
}

module "codebuild_policy" {
  source      = "../../modules/iam-policies"
  policy_name = "codebuild-execution-dev"
}

module "codebuild_role" {
  source        = "../../modules/iam-roles"
  role_name     = "codebuild-execution-dev"
  resource_type = "codebuild"
  policy_arn    = "${module.codebuild_policy.policy_arn}"
}


module "codepipeline_policy" {
  source      = "../../modules/iam-policies"
  policy_name = "codePipeline-execution-dev"
}

module "code_pipeline_role" {
  source        = "../../modules/iam-roles"
  role_name     = "codePipeline-execution-dev"
  resource_type = "codePipeline"
  policy_arn    = "${module.codepipeline_policy.policy_arn}"
}


module "sdao_lambda_policy" {
  source      = "../../modules/iam-policies"
  policy_name = "sdao_lambda_execution_dev"
}


module "sdao_lambda_role" {
  source        = "../../modules/iam-roles"
  role_name     = "sdao_lambda_execution_dev"
  resource_type = "lambda"
  policy_arn    = "${module.sdao_lambda_policy.policy_arn}"
}
