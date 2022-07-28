module "bastion_policy" {
  source      = "../../modules/iam-policies"
  policy_name = "bastion-policy-prod"
}
module "bastion_role" {
  source        = "../../modules/iam-roles"
  role_name     = "bastion-role-prod"
  resource_type = "ec2"
  policy_arn    = "${module.bastion_policy.policy_arn}"
}

module "bastion_instance_profile" {
  source    = "../../modules/instance-profile"
  role_name = "bastion-role-prod"
}

module "codebuild_policy" {
  source      = "../../modules/iam-policies"
  policy_name = "codebuild-execution-prod"
}

module "codebuild_role" {
  source        = "../../modules/iam-roles"
  role_name     = "codebuild-execution-prod"
  resource_type = "codebuild"
  policy_arn    = "${module.codebuild_policy.policy_arn}"
}


module "codepipeline_policy" {
  source      = "../../modules/iam-policies"
  policy_name = "codePipeline-execution-prod"
}

module "code_pipeline_role" {
  source        = "../../modules/iam-roles"
  role_name     = "codePipeline-execution-prod"
  resource_type = "codePipeline"
  policy_arn    = "${module.codepipeline_policy.policy_arn}"
}

module "sdao_lambda_policy" {
  source      = "../../modules/iam-policies"
  policy_name = "sdao_lambda_execution_prod"
}


module "sdao_lambda_role" {
  source        = "../../modules/iam-roles"
  role_name     = "sdao_lambda_execution_prod"
  resource_type = "lambda"
  policy_arn    = "${module.sdao_lambda_policy.policy_arn}"
}

module "sdao_sftp_policy" {
  source      = "../../modules/iam-policies"
  policy_name = "sdao-sftp-policy"
}

module "sdao_sftp_role" {
  source        = "../../modules/iam-roles"
  role_name     = "sdao-sftp-role"
  resource_type = "transfer"
  policy_arn    = "${module.sdao_sftp_policy.policy_arn}"
}
