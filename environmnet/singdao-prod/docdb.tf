variable "docdb_password" {
  default = ""
}

variable "docdb_password2" {
  default = ""
  
}

module "docdb_setup" {
  source              = "../../modules/documentDB"
  cluster_identifier  = "sdao-dynasetdocdb-cluster-prod"
  name                = "sdao-dynaset-docdb-prod"
  engine              = "docdb"
  instance_class      = "db.r5.large"
  instance_identifier = "sdao-dynaset-db-prod"
  database_name       = "sdao_dynaset_prod_db"
  master_username     = "sdao_dynaset_prod_db_admin"
  docdb_password      = "${var.docdb_password}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}


module "docdb_setup_2_prod" {
  source              = "../../modules/documentDB"
  cluster_identifier  = "dynaset-cluster-prod"
  name                = "dynaset-db-prod"
  engine              = "docdb"
  instance_class      = "db.r5.large"
  instance_identifier = "dynaset-db-prod"
  database_name       = "dynaset_db_prod"
  master_username     = "dynaset_db_prod_admin"
  docdb_password      = "${var.docdb_password2}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}
