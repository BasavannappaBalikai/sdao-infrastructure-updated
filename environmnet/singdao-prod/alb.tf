variable "certificate_arn" {
  default = ""
}


module "onchain-server-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["onchain-server-alb-tg-prod"]
  health_path       = ["/health"]
  ports             = [3000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}



module "onchain-server-alb" {
  source         = "../../modules/alb"
  name           = "onchain-server-alb-prod"
  sg_id          = "${module.http-sg.sg_id}"
  public_subnets = "${module.vpc.public_subnets}"
}


/*module "onchain-ssl-listener" {
  source            = "../../modules/alb-ssl-listener"
  load_balancer_arn = "${module.onchain-server-alb.alb_arn}"
  certificate_arn   = var.certificate_arn
  target_group_arn  = "${module.onchain-server-targets.target_arn}"
}*/

module "onchain-server-listener" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = "${module.onchain-server-alb.alb_arn}"
  target_group_arn  = "${module.onchain-server-targets.target_arn}"
}

module "dynaset-backend-server-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["dynaset-backend-prod-alb-tg"]
  health_path       = ["/dynaset-server/api/health"]
  ports             = [3000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}



module "launchpad-api-targets-prod" {
  source            = "../../modules/alb-target"
  target_group_name = ["launchpad-api-prod-alb-tg"]
  health_path       = ["/v1/api"]
  ports             = [3000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}

module "launchpad-api-alb-prod" {
  source         = "../../modules/alb"
  name           = "launchpad-api-alb-prod"
  sg_id          = "${module.http-sg.sg_id}"
  public_subnets = "${module.vpc.public_subnets}"
}

module "launchpad-api-listener-prod" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = "${module.launchpad-api-alb-prod.alb_arn}"
  target_group_arn  = "${module.launchpad-api-targets-prod.target_arn}"

}

module "launchpad-ssl-listener-prod" {
  source            = "../../modules/alb-ssl-listener"
  load_balancer_arn = "${module.launchpad-api-alb-prod.alb_arn}"
  certificate_arn   = var.certificate_arn
  target_group_arn  = "${module.launchpad-api-targets-prod.target_arn}"
}





module "msd-api-targets-prod" {
  source            = "../../modules/alb-target"
  target_group_name = ["msd-api-prod-alb-tg"]
  health_path       = ["/api/v0/msd/test"]
  ports             = [80]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}

module "msd-api-alb-prod" {
  source         = "../../modules/alb"
  name           = "msd-api-alb-prod"
  sg_id          = "${module.http-sg.sg_id}"
  public_subnets = "${module.vpc.public_subnets}"
}

module "msd-api-listener-prod" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = "${module.msd-api-alb-prod.alb_arn}"
  target_group_arn  = "${module.msd-api-targets-prod.target_arn}"

}

module "msd-api-ssl-listener-prod" {
  source            = "../../modules/alb-ssl-listener"
  load_balancer_arn = "${module.msd-api-alb-prod.alb_arn}"
  certificate_arn   = var.certificate_arn
  target_group_arn  = "${module.msd-api-targets-prod.target_arn}"
}
