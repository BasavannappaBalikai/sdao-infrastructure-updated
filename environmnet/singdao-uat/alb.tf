variable "certificate_arn" {
  default = ""
}


/*module "onchain-server-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["onchain-server-alb-tg-uat", "dynaset-backend-uat-alb-tg-uat"]
  health_path       = ["/health", "/dynaset-server/api/health"]
  ports             = [3000, 4000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}*/

module "onchain-server-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["onchain-server-alb-tg-uat", "dynaset-backend-uat-alb-tg"]
  health_path       = ["/health", "/dynaset-server/api/health"]
  ports             = [3000, 3000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}


module "onchain-server-alb" {
  source         = "../../modules/alb"
  name           = "onchain-server-alb-uat"
  sg_id          = "${module.http-sg.sg_id}"
  public_subnets = "${module.vpc.public_subnets}"
}


module "onchain-ssl-listener" {
  source            = "../../modules/alb-ssl-listener"
  load_balancer_arn = "${module.onchain-server-alb.alb_arn}"
  certificate_arn   = var.certificate_arn
  target_group_arn  = "${module.onchain-server-targets.target_arn}"
}


module "onchain-server-listener" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = "${module.onchain-server-alb.alb_arn}"
  target_group_arn  = "${module.onchain-server-targets.target_arn}"
}

/*module "dynaset-backend-server-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["dynaset-backend-uat-alb-tg"]
  health_path       = ["/dynaset-server/api/health"]
  ports             = [3000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}*/
##############

module "onchain-dynasets-listener-rule" {
  source       = "../../modules/alb-listener-rule"
  listener_arn = "${module.onchain-server-listener.listener_arn}"
  priority     = [101, 99]
  target_arn   = "${module.onchain-server-targets.target_arn}"
  paths        = ["/onchain-server/*", "/dynaset-server/*"]
}
