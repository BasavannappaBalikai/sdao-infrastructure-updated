module "http-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "http-dev-sg"
  security_ports = [80, 443, 3000]
  cidr_blocks    = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]
}

module "rds-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "rds-dev-sg"
  security_ports = ["3306"]
  cidr_blocks    = ["0.0.0.0/0"]
}

module "bastion-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "bastion-sg"
  security_ports = ["3012", "22", "80", "443"]
  cidr_blocks    = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]
}

module "rds-postgres-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "rds-postgres-sg"
  security_ports = ["5432"]
  cidr_blocks    = ["0.0.0.0/0"]
}

module "efs-mount-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "efs-mount-sg"
  security_ports = ["2049"]
  cidr_blocks    = ["10.0.0.0/16"]
}
