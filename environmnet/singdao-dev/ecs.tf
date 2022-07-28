variable "ecsTaskExecutionRole" {
  default = ""
}

module "sdao-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["onchain_server"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}

module "sdao-ecs-service-dev" {
  source              = "../../modules/ecs-service"
  service_name        = ["onchain-server-ecs-service"]
  container_name      = "onchain_server"
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/onchain-server-cluster"
  task_definition_arn = "${module.sdao-task-definition.task_definition_arn}"
  desired_count       = [1]
  #            = var.ecs_role
  launch_type    = "FARGATE"
  target_arns    = "${module.onchain-server-targets.target_arn}"
  container_port = [3000]
  subnets        = "${module.vpc.private_subnets}"
  ecs_sg         = ["${module.http-sg.sg_id}"]
  type           = "ECS"

}

module "sdao-dynaset-backend-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["dynaset_backend_server_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}

module "sdao-dynaset-backend-service-dev" {
  source              = "../../modules/ecs-service"
  service_name        = ["dynaset-backend-ecs-service"]
  container_name      = "dynaset_backend_server_dev"
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/dynaset-backend-dev"
  task_definition_arn = "${module.sdao-dynaset-backend-task-definition.task_definition_arn}"
  desired_count       = [1]
  #            = var.ecs_role
  launch_type    = "FARGATE"
  target_arns    = "${module.dynaset-backend-server-targets.target_arn}"
  container_port = [3000]
  subnets        = "${module.vpc.private_subnets}"
  ecs_sg         = ["${module.http-sg.sg_id}"]
  type           = "ECS"

}



module "sdao-dynaset-backend-master-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["dynaset_backend_server_master_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-dynaset-backend-master-services" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["dynaset-backend-master-ecs-service"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/dynaset-backend-master-dev"
  task_definition_arn = "${module.sdao-dynaset-backend-master-task-definition.task_definition_arn}"
  desired_count       = [1]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}


module "sdao-portfolio-api-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["portfolio_api_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-portfolio-api-service-dev" {
  source              = "../../modules/ecs-service"
  service_name        = ["portfolio-api-dev-ecs-service"]
  container_name      = "portfolio_api_dev"
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/portfolio-api-dev"
  task_definition_arn = "${module.sdao-portfolio-api-task-definition.task_definition_arn}"
  desired_count       = [1]
  #            = var.ecs_role
  launch_type    = "FARGATE"
  target_arns    = "${module.portfolio-api-targets.target_arn}"
  container_port = [49525]
  subnets        = "${module.vpc.private_subnets}"
  ecs_sg         = ["${module.http-sg.sg_id}"]
  type           = "ECS"

}

module "sdao-token-holder-scraper-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["token_holder_scraper_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-token-holder-scraper-services" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["token-holder-scraper-ecs-service"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/token-holder-scraper-dev"
  task_definition_arn = "${module.sdao-token-holder-scraper-task-definition.task_definition_arn}"
  desired_count       = [1]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}


module "sdao-token-holder-binance-scraper-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["token_holder_binance_scraper_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-token-holder-binance-scraper-services" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["token-holder--binance-scraper-ecs-service"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/token-holder-scraper-dev"
  task_definition_arn = "${module.sdao-token-holder-binance-scraper-task-definition.task_definition_arn}"
  desired_count       = [1]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}

module "sdao-token-holder-unbounded-bsc-scraper-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["unbounded_bsc_scraper_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}

module "sdao-token-holder-unbounded-bsc-scraper-services" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["token-holder-unbounded-bsc-ecs-service"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/token-holder-scraper-dev"
  task_definition_arn = "${module.sdao-token-holder-unbounded-bsc-scraper-task-definition.task_definition_arn}"
  desired_count       = [1]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}

module "sdao-token-holder-unbounded-erc-scraper-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["unbounded_erc_scraper_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}

module "sdao-token-holder-unbounded-erc-scraper-services" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["token-holder-unbounded-erc-ecs-service"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/token-holder-scraper-dev"
  task_definition_arn = "${module.sdao-token-holder-unbounded-erc-scraper-task-definition.task_definition_arn}"
  desired_count       = [1]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}



module "sdao-launchpad-api-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["launchpad_api_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [2048]
  memory                   = [4096]
  network_mode             = "awsvpc"
  environment              = "dev"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-launchpad-api-service-dev" {
  source              = "../../modules/ecs-service"
  service_name        = ["launchpad-api-dev-ecs-service"]
  container_name      = "launchpad_api_dev"
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/launchpad-api-dev"
  task_definition_arn = "${module.sdao-launchpad-api-task-definition.task_definition_arn}"
  desired_count       = [1]
  #            = var.ecs_role
  launch_type    = "FARGATE"
  target_arns    = "${module.launchpad-api-targets.target_arn}"
  container_port = [3000]
  subnets        = "${module.vpc.private_subnets}"
  ecs_sg         = ["${module.http-sg.sg_id}"]
  type           = "ECS"

}





module "sdao-token-holder-lp-sdao-scrapers-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["lp_sdao_usdt_scraper_dev", "lp_sdao_usd_scraper_dev", "lp_sdao_bnb_scraper_dev", "lp_sdao_weth_scraper_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512, 512, 512, 512]
  memory                   = [1024, 1024, 1024, 1024]
  network_mode             = "awsvpc"
  environment              = "dev"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}

module "sdao-token-holder-lp-sdao-scrapers-services" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["token-holders-lp-sdao-usdt-ecs-service", "token-holder-lp-sdao-usd-ecs-service", "token-holder-lp-sdao-bnb-ecs-service", "token-holder-lp-sdao-weth-ecs-service"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/token-holder-scraper-dev"
  task_definition_arn = "${module.sdao-token-holder-lp-sdao-scrapers-task-definition.task_definition_arn}"
  desired_count       = [0, 0, 0, 0]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}


module "sdao-huginexpert-fast-api-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["huginexpert_fast_api_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "dev"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-huginexpert-fast-api-service-dev" {
  source              = "../../modules/ecs-service"
  service_name        = ["huginexpert-fast-api-dev-ecs-service"]
  container_name      = "huginexpert_fast_api_dev"
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/huginexpert-fast-api-dev"
  task_definition_arn = "${module.sdao-huginexpert-fast-api-task-definition.task_definition_arn}"
  desired_count       = [1]
  #            = var.ecs_role
  launch_type    = "FARGATE"
  target_arns    = "${module.huginexpert-fast-api-targets.target_arn}"
  container_port = [49000]
  subnets        = "${module.vpc.private_subnets}"
  ecs_sg         = ["${module.http-sg.sg_id}"]
  type           = "ECS"

}




module "bonded-data-scraper-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["bonded_data_scraper_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "dev"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}

module "bonded-data-scraper-ecs-service" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["bonded-data-scraper-ecs-service-dev"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/token-holder-scraper-dev"
  task_definition_arn = "${module.bonded-data-scraper-task-definition.task_definition_arn}"
  desired_count       = [0]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}


module "eth-scraper-3m-scraper-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["eth_scraper_3m_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "dev"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}

module "eth-scraper-3m-ecs-service" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["eth-scraper-3m-ecs-service-dev"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/token-holder-scraper-dev"
  task_definition_arn = "${module.eth-scraper-3m-scraper-task-definition.task_definition_arn}"
  desired_count       = [0]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}


module "eth-scraper-6m-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["eth_scraper_6m_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "dev"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "eth-scraper-6m-ecs-service" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["eth-scraper-6m-ecs-service-dev"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/token-holder-scraper-dev"
  task_definition_arn = "${module.eth-scraper-6m-task-definition.task_definition_arn}"
  desired_count       = [0]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}


module "tradingbot-ask-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["tradingbot_dev"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "dev"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "tradingbo-ecs-service" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["tradingbo-ecs-service-dev"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/trading-bot-dev"
  task_definition_arn = "${module.tradingbot-ask-definition.task_definition_arn}"
  desired_count       = [1]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}
