
variable "db_password_2" {
  default = ""
}

variable "db_password_3" {
  default = ""
}

variable "db_password_4" {
  default = ""
}


module "rds_postgres_setup" {
  source           = "../../modules/rds-postgres"
  storage_size     = 20
  storage_type     = "gp2"
  db_type          = "postgres"
  db_version       = "13.3"
  db_instance_type = "db.t3.medium"
  name             = "sdao-launchpad-db-dev"
  db_name          = "sdao_launchpad_db"
  db_username      = "sdao_launchpad_db_admin"
  db_password      = "${var.db_password_2}"
  db_subnet_ids    = "${module.vpc.private_subnets}"
  security_groups  = ["${module.rds-sg.sg_id}"]
  multi_az         = false
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}



module "aurora_postgres_governance_cluster" {
  source             = "../../modules/aurora-postgres"
  cluster_identifier = "governance-db-cluster-dev"
  name               = "governance-db-cluster-dev"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  instance_class     = "db.t3.medium"
  engine_version     = "13.4"
  #instance_engine_version = "10.7"
  #replica_count       = 0
  instance_identifier = "token-holder-scrapers-db-dev"
  database_name       = "token_holder_scraper_eth_db"
  master_username     = "token_holder_scraper_eth_db_admin"
  master_password     = "${var.db_password_3}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}




module "rds_launchpad_api_setup" {
  source           = "../../modules/rds-postgres"
  storage_size     = 20
  storage_type     = "gp2"
  db_type          = "postgres"
  db_version       = "13.3"
  db_instance_type = "db.t3.medium"
  name             = "sdao-launchpad-api-db-dev"
  db_name          = "sdao_launchpad_api_db"
  db_username      = "sdao_launchpad_api_db_admin"
  db_password      = "${var.db_password_4}"
  db_subnet_ids    = "${module.vpc.private_subnets}"
  security_groups  = ["${module.rds-sg.sg_id}"]
  multi_az         = false
  tags = {
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}
