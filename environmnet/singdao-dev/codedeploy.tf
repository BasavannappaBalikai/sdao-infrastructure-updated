module "sdao-codedeploy" {
  source                = "../../modules/codedeploy"
  name                  = "onchain_data_server_app"
  deployment_group_name = "onchain_data_server_deployment_group"
  service_role_arn      = "arn:aws:iam::925884611165:role/code_deploy_role"
  cluster_name          = "onchain-server-cluster"
  service_name          = "onchain-server-ecs-service"
  listener_arns         = "${module.onchain-server-listener.listener_arn}"
  target_group_1        = "onchain-server-alb-tg-1"
  target_group_2        = "onchain-server-alb-tg-2"


  #  listener_arns         = "${module.onchain-server-alb.alb_arn}"
  #  alb_target_name       = "${module.onchain-server-targets.target_arn}"
}
