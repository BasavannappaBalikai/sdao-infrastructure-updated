variable "ecsTaskExecutionRole" {
  default = ""
}

module "sdao-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["onchain_server_prod"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "prod"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}



module "sdao-ecs-service-prod" {
  source              = "../../modules/ecs-service"
  service_name        = ["onchain-server-ecs-service-prod"]
  container_name      = "onchain_server_prod"
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/onchain-server-cluster-prod"
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



####

module "sdao-scrapers-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["binance_scraper", "coinbase_scraper", "deribit_scraper", "kucoin_scraper", "exchange_data_scraper", "binance_scraper_v2"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [1024, 1024, 1024, 1024, 2048, 1024]
  memory                   = [2048, 2048, 2048, 2048, 4096, 2048]
  network_mode             = "awsvpc"
  environment              = "prod"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-scrapers-services" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["binance-scraper-ecs-service", "coinbase-scraper-ecs-service", "deribit-scraper-ecs-service", "kucoin-scraper-ecs-service", "exchange-data-scraper-ecs-service", "binance-scraper-v2-ecs-service"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/sdao-scrapers-cluster"
  task_definition_arn = "${module.sdao-scrapers-task-definition.task_definition_arn}"
  desired_count       = [0, 0, 1, 1, 1, 1]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}



module "sdao-dynaset-backend-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["dynaset_backend_server_prod"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "prod"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}

module "sdao-dynaset-backend-service-prod" {
  source              = "../../modules/ecs-service"
  service_name        = ["dynaset-backend-ecs-service-prod"]
  container_name      = "dynaset_backend_server_prod"
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/dynaset-backend-prod"
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
  task_definition          = ["dynaset_backend_server_master_prod"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "prod"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-dynaset-backend-master-services" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["dynaset-backend-prod-master-ecs-service"]
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/dynaset-backend-master-prod"
  task_definition_arn = "${module.sdao-dynaset-backend-master-task-definition.task_definition_arn}"
  desired_count       = [1]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.http-sg.sg_id}"]
  type        = "ECS"
}

module "sdao-launchpad-api-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["launchpad_api_prod"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [2048]
  memory                   = [4096]
  network_mode             = "awsvpc"
  environment              = "prod"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-launchpad-api-service-prod" {
  source              = "../../modules/ecs-service"
  service_name        = ["launchpad-api-prod-ecs-service"]
  container_name      = "launchpad_api_prod"
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/launchpad-api-prod"
  task_definition_arn = "${module.sdao-launchpad-api-task-definition.task_definition_arn}"
  desired_count       = [1]
  #            = var.ecs_role
  launch_type    = "FARGATE"
  target_arns    = "${module.launchpad-api-targets-prod.target_arn}"
  container_port = [3000]
  subnets        = "${module.vpc.private_subnets}"
  ecs_sg         = ["${module.http-sg.sg_id}"]
  type           = "ECS"
}


module "sdao-msd-api-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["msd_api_prod"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "prod"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-msd-api-service" {
  source              = "../../modules/ecs-service"
  service_name        = ["msd-api-prod-ecs-service"]
  container_name      = "msd_api_prod"
  cluster_id          = "arn:aws:ecs:eu-west-1:925884611165:cluster/msd-api-prod"
  task_definition_arn = "${module.sdao-msd-api-task-definition.task_definition_arn}"
  desired_count       = [1]
  #            = var.ecs_role
  launch_type    = "FARGATE"
  target_arns    = "${module.msd-api-targets-prod.target_arn}"
  container_port = [80]
  subnets        = "${module.vpc.private_subnets}"
  ecs_sg         = ["${module.http-sg.sg_id}"]
  type           = "ECS"

}
