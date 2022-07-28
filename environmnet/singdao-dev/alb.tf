variable "certificate_arn" {
  default = ""
}


module "onchain-server-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["onchain-server-alb-tg-1"]
  health_path       = ["/api"]
  ports             = [3000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}



module "onchain-server-alb" {
  source         = "../../modules/alb"
  name           = "onchain-server-alb-dev"
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

module "onchain-listener-rule" {
  source       = "../../modules/alb-listener-rule"
  listener_arn = "${module.onchain-server-listener.listener_arn}"
  #priority     = [101, 99, 98, 97]
  target_arn = "${module.dynaset-backend-server-targets.target_arn}"
  paths      = ["/dynaset-server/*"]
}

module "dynaset-backend-server-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["dynaset-backend-dev-alb-tg"]
  health_path       = ["/dynaset-server/api/health"]
  ports             = [3000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}




module "portfolio-api-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["portfolio-api-dev-alb-tg"]
  health_path       = ["/"]
  ports             = [49525]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}
module "portfolio-api-dev-alb" {
  source         = "../../modules/alb"
  name           = "portfolio-api-alb-dev"
  sg_id          = "${module.http-sg.sg_id}"
  public_subnets = "${module.vpc.public_subnets}"
}

module "portfolio-api-listener" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = "${module.portfolio-api-dev-alb.alb_arn}"
  target_group_arn  = "${module.portfolio-api-targets.target_arn}"

}


module "launchpad-api-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["launchpad-api-alb-tg"]
  health_path       = ["/v1/api"]
  ports             = [3000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}

module "launchpad-api-alb" {
  source         = "../../modules/alb"
  name           = "launchpad-api-alb-dev"
  sg_id          = "${module.http-sg.sg_id}"
  public_subnets = "${module.vpc.public_subnets}"
}

module "launchpad-api-listener" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = "${module.launchpad-api-alb.alb_arn}"
  target_group_arn  = "${module.launchpad-api-targets.target_arn}"

}

module "launchpad-ssl-listener" {
  source            = "../../modules/alb-ssl-listener"
  load_balancer_arn = "${module.launchpad-api-alb.alb_arn}"
  certificate_arn   = var.certificate_arn
  target_group_arn  = "${module.launchpad-api-targets.target_arn}"
}


module "huginexpert-fast-api-targets" {
  source            = "../../modules/alb-target"
  target_group_name = ["huginexpert-fast-api-dev-alb-tg"]
  health_path       = ["/"]
  ports             = [49000]
  vpc_id            = "${module.vpc.vpc_id}"
  target_type       = "ip"
}
module "huginexpert-fast-api-dev-alb" {
  source         = "../../modules/alb"
  name           = "huginexpert-fast-api-alb-dev"
  sg_id          = "${module.http-sg.sg_id}"
  public_subnets = "${module.vpc.public_subnets}"
}

module "huginexpert-fast-api-listener" {
  source            = "../../modules/alb-listener"
  load_balancer_arn = "${module.huginexpert-fast-api-dev-alb.alb_arn}"
  target_group_arn  = "${module.huginexpert-fast-api-targets.target_arn}"

}

module "huginexpert-fast-api-ssl-listener" {
  source            = "../../modules/alb-ssl-listener"
  load_balancer_arn = "${module.huginexpert-fast-api-dev-alb.alb_arn}"
  certificate_arn   = var.certificate_arn
  target_group_arn  = "${module.huginexpert-fast-api-targets.target_arn}"
}
