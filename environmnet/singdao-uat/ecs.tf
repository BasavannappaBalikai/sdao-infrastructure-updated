variable "ecsTaskExecutionRole" {
  default = ""
}

module "sdao-onchain-server-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["onchain_server_uat"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}



module "sdao-onchain-server-ecs-service" {
  source              = "../../modules/ecs-service"
  service_name        = ["onchain-server-ecs-service-uat"]
  container_name      = "onchain_server_uat"
  cluster_id          = "arn:aws:ecs:eu-west-1:377995165915:cluster/onchain-server-cluster-uat"
  task_definition_arn = "${module.sdao-onchain-server-task-definition.task_definition_arn}"
  desired_count       = [1]
  #            = var.ecs_role
  launch_type    = "FARGATE"
  target_arns    = ["${module.onchain-server-targets.target_arn[0]}"]
  container_port = [3000]
  subnets        = "${module.vpc.private_subnets}"
  ecs_sg         = ["${module.ecs-service-sg.sg_id}"]
  type           = "ECS"

}



module "sdao-dynaset-backend-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["dynaset_backend_server_uat"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}

module "sdao-dynaset-backend-service-uat" {
  source              = "../../modules/ecs-service"
  service_name        = ["dynaset-backend-ecs-service-uat"]
  container_name      = "dynaset_backend_server_uat"
  cluster_id          = "arn:aws:ecs:eu-west-1:377995165915:cluster/dynaset-backend-uat"
  task_definition_arn = "${module.sdao-dynaset-backend-task-definition.task_definition_arn}"
  desired_count       = [1]
  #            = var.ecs_role
  launch_type    = "FARGATE"
  target_arns    = ["${module.onchain-server-targets.target_arn[1]}"]
  container_port = [3000]
  subnets        = "${module.vpc.private_subnets}"
  ecs_sg         = ["${module.ecs-service-sg.sg_id}"]
  type           = "ECS"

}



module "sdao-dynaset-backend-master-task-definition" {
  source                   = "../../modules/ecs-taskdefinition"
  task_definition          = ["dynaset_backend_server_master_uat"]
  requires_compatibilities = ["FARGATE"]
  cpu                      = [512]
  memory                   = [1024]
  network_mode             = "awsvpc"
  environment              = "uat"
  ecsTaskExecutionRole     = var.ecsTaskExecutionRole
}


module "sdao-dynaset-backend-master-services" {
  source              = "../../modules/ecs-service-without-alb"
  service_name        = ["dynaset-backend-uat-master-ecs-service"]
  cluster_id          = "arn:aws:ecs:eu-west-1:377995165915:cluster/dynaset-backend-master-uat"
  task_definition_arn = "${module.sdao-dynaset-backend-master-task-definition.task_definition_arn}"
  desired_count       = [1]
  #  ecs_role            = var.ecs_role
  launch_type = "FARGATE"
  subnets     = "${module.vpc.private_subnets}"
  ecs_sg      = ["${module.ecs-service-sg.sg_id}"]
  type        = "ECS"
}
