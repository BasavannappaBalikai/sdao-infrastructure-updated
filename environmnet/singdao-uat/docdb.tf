variable "docdb_password1" {
  default = ""
}

variable "docdb_password2" {
  default = ""

}

module "trading_dashboard_docdb_setup" {
  source              = "../../modules/documentDB"
  cluster_identifier  = "sdao-trading-dashboard-cluster-uat"
  name                = "sdao-trading-dashboard-docdb-uat"
  engine              = "docdb"
  instance_class      = "db.r5.large"
  instance_identifier = "sdao-trading-dashboard-docdb-uat"
  database_name       = "sdao_trading_dashboard_uat_db"
  master_username     = "sdao_trading_dashboard_uat_db_admin"
  docdb_password      = "${var.docdb_password1}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.trading-dashboard-docdb-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
  }
}


module "dynasets_docdb_setup" {
  source              = "../../modules/documentDB"
  cluster_identifier  = "sdao-dynaset-docdb-cluster-uat"
  name                = "sdao-dynaset-docdb-uat"
  engine              = "docdb"
  instance_class      = "db.r5.large"
  instance_identifier = "sdao-dynaset-docdb-uat"
  database_name       = "sdao_dynaset_db_uat"
  master_username     = "sdao_dynaset_db_uat_admin"
  docdb_password      = "${var.docdb_password2}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.dynaset-docdb-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
  }
}
