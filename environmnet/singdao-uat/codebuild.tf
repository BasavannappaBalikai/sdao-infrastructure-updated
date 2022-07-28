/*module "sdao-launchpad-codebuild" {
  source             = "../../modules/codebuild-launchpad"
  name               = ["launchpad_server-uat"]
  image_name         = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-serverless"
  config_bucket      = "singdao-config-prod"
  environment        = "uat"
  target_bucket      = "${module.sdao_artifact_store.bucket_name}"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "LOCAL"
  cache_modes        = ["LOCAL_CUSTOM_CACHE", "LOCAL_SOURCE_CACHE"]
  location           = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch             = "main"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "launchpad_frontend" {
  source             = "../../modules/codebuild-launchpad"
  name               = ["launchpad_frontend-uat"]
  image_name         = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  config_bucket      = "singdao-config-uat"
  environment        = "uat"
  target_bucket      = "${module.sdao_launchpad_frontend.bucket_name}"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch             = "main"
  NODE_ENV           = "uat"
  NODE_OPTIONS       = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "launchpad_portal_admin" {
  source             = "../../modules/codebuild-launchpad"
  name               = ["launchpad_admin-uat"]
  image_name         = "925884611165.dkr.ecr.eu-west-1.amazonaws.com/codebuild:node-14-stretch"
  config_bucket      = "singdao-config-prod"
  environment        = "uat"
  target_bucket      = "${module.sdao_launchpad_admin.bucket_name}"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "LOCAL"
  cache_modes        = ["LOCAL_CUSTOM_CACHE", "LOCAL_SOURCE_CACHE"]
  location           = "https://github.com/Singularity-DAO/sdao-monorepo.git"
  branch             = "main"
  NODE_OPTIONS       = "--max-old-space-size=4096"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}
*/

module "sdao-codebuild-projects" {
  source             = "../../modules/codebuild"
  name               = ["onchain_server-uat"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "uat"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/onchain_data_server.git"
  branch             = "UAT"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


module "trading_dashboard_app" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["trading_dashboard-uat"]
  image_name                  = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
  image_pull_credentials_type = "CODEBUILD"
  config_bucket               = "singdao-config-uat"
  environment                 = "uat"
  target_bucket               = "${module.trading_dashboard_bucket.bucket_name}"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "NO_CACHE"
  #cache_type         = "S3"
  #cache_location     = "monorepo-cache/trading-dashboard_uat"
  location = "https://github.com/Singularity-DAO/trading-dashboard-app.git"
  branch   = "UAT"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}

module "dynaset-backend" {
  source             = "../../modules/codebuild"
  name               = ["dynaset_backend-uat"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "uat"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/dynaset-backend.git"
  branch             = "uat"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}



module "dynaset-backend-master" {
  source             = "../../modules/codebuild"
  name               = ["dynaset_backend_master-uat"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "uat"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/dynaset-backend.git"
  branch             = "uat"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}



module "sdao-dapp-codebuild" {
  source                      = "../../modules/codebuild-launchpad"
  name                        = ["dapp-uat"]
  image_name                  = "377995165915.dkr.ecr.eu-west-1.amazonaws.com/codebuild:latest"
  image_pull_credentials_type = "SERVICE_ROLE"
  config_bucket               = "singdao-config-uat"
  environment                 = "uat"
  target_bucket               = "${module.sdao_artifact_store.bucket_name}"
  vpc_id                      = "${module.vpc.vpc_id}"
  subnets                     = "${module.vpc.private_subnets}"
  security_group_ids          = ["${module.rds-sg.sg_id}"]
  role_arn                    = "${module.codebuild_role.role_arn}"
  cache_type                  = "S3"
  cache_location              = "singdao-config-uat/dapp-uat"
  location                    = "https://github.com/Singularity-DAO/dapp.git"
  NODE_OPTIONS                = "--max-old-space-size=4096"
  branch                      = "uat"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}



module "docker-build-1" {
  source             = "../../modules/codebuild"
  name               = ["docker-build-uat"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "uat"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "NO_CACHE"
  location           = "https://github.com/Singularity-DAO/dynaset-backend.git"
  branch             = "uat"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}


#***********************

/*module "sdao-codebuild-projects-2" {
  source             = "../../modules/codebuild-launchpad"
  name               = ["sdao-ui"]
  image_name         = "aws/codebuild/standard:5.0"
  environment        = "uat"
  vpc_id             = "${module.vpc.vpc_id}"
  subnets            = "${module.vpc.private_subnets}"
  security_group_ids = ["${module.rds-sg.sg_id}"]
  role_arn           = "${module.codebuild_role.role_arn}"
  cache_type         = "S3"
  cache_location     = "monorepo-cache/trading-dashboard_uat"
  location           = "https://github.com/Singularity-DAO/sdao-ui.git"

  branch = "main"
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
    Owner       = "Basavaraj B"
  }
}
*/
