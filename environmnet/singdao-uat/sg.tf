module "http-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "http-uat-sg"
  security_ports = [80, 443]
  cidr_blocks    = ["0.0.0.0/0", "0.0.0.0/0"]
}

module "rds-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "rds-uat-sg"
  security_ports = ["3306"]
  cidr_blocks    = ["0.0.0.0/0"]
}

module "bastion-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "bastion-uat-sg"
  security_ports = ["3012", "22", "80", "443"]
  cidr_blocks    = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]
}

module "rds-postgres-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "rds-postgres-uat-sg"
  security_ports = ["5432"]
  cidr_blocks    = ["0.0.0.0/0"]
}

module "trading-dashboard-docdb-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "trading-dashboard-docdb-uat-sg"
  security_ports = ["27017"]
  cidr_blocks    = ["0.0.0.0/0"]
}

module "dynaset-docdb-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "dynaset-docdb-uat-sg"
  security_ports = ["27017"]
  cidr_blocks    = ["0.0.0.0/0"]
}

module "ecs-service-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "ecs-service-uat-sg"
  security_ports = ["3000", "4000", "5000"]
  cidr_blocks    = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]
}
