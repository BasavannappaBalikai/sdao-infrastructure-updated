variable "docdb_password" {
  default = ""
}

variable "docdb_password2" {
  default = ""
}

variable "docdb_password3" {
  default = ""
}

module "docdb_setup" {
  source              = "../../modules/documentDB"
  cluster_identifier  = "sdao-dynasetdocdb-cluster-dev"
  name                = "sdao-dynaset-docdb-dev"
  engine              = "docdb"
  instance_class      = "db.r5.large"
  instance_identifier = "sdao-dynaset-db-dev"
  database_name       = "sdao_dynaset_db"
  master_username     = "sdao_dynaset_db_db_admin"
  docdb_password      = "${var.docdb_password}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}

module "docdb_setup_2" {
  source              = "../../modules/documentDB"
  cluster_identifier  = "dynaset-cluster-dev"
  name                = "dynaset-db-dev"
  engine              = "docdb"
  instance_class      = "db.r5.large"
  instance_identifier = "dynaset-db-dev"
  database_name       = "dynaset_db_dev"
  master_username     = "dynaset_db_dev_admin"
  docdb_password      = "${var.docdb_password2}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}

module "docdb_setup_3" {
  source              = "../../modules/documentDB"
  cluster_identifier  = "yield-server-cluster-dev"
  name                = "yield-server-db-dev"
  engine              = "docdb"
  instance_class      = "db.r5.large"
  instance_identifier = "yield-server-db-dev"
  database_name       = "yield_server_db_dev"
  master_username     = "yield_server_db_dev_admin"
  docdb_password      = "${var.docdb_password3}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}
