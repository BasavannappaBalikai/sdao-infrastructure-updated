module "http-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "http-prod-sg"
  security_ports = [80, 443]
  cidr_blocks    = ["0.0.0.0/0", "0.0.0.0/0"]
}

module "rds-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "rds-prod-sg"
  security_ports = ["3306"]
  cidr_blocks    = ["0.0.0.0/0"]
}

module "bastion-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "bastion-prod-sg"
  security_ports = ["3012", "22", "80", "443"]
  cidr_blocks    = ["0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0", "0.0.0.0/0"]
}

module "rds-postgres-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "rds-postgres-prod-sg"
  security_ports = ["5432"]
  cidr_blocks    = ["0.0.0.0/0"]
}

module "sdao-ai-ec2-instance-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "ec2-ai-instance-sg"
  security_ports = ["22"]
  cidr_blocks    = ["0.0.0.0/0"]
}

module "sdao-data-analytics-instance-sg" {
  source         = "../../modules/security_groups"
  vpc_id         = "${module.vpc.vpc_id}"
  sg_name        = "ec2-data-analytics-instance-sg"
  security_ports = ["22"]
  cidr_blocks    = ["0.0.0.0/0"]
}
