variable "db_password" {
  default = ""
}


variable "db_password_2" {
  default = ""
}

variable "db_password_3" {
  default = ""
}

variable "db_password_4" {
  default = ""
}

variable "db_password_5" {
  default = ""
}

variable "db_password_6" {
  default = ""
}

variable "db_password_7" {
  default = ""
}

variable "db_password_8" {
  default = ""
}

variable "db_password_9" {
  default = ""
}

module "rds_postgres_setup" {
  source           = "../../modules/rds-postgres"
  storage_size     = 20
  storage_type     = "gp2"
  db_type          = "postgres"
  db_version       = "13.3"
  db_instance_type = "db.t3.medium"
  name             = "sdao-launchpad-prod-db"
  db_name          = "sdao_launchpad_prod"
  db_username      = "sdao_launchpad_prod_admin"
  db_password      = "${var.db_password}"
  db_subnet_ids    = "${module.vpc.private_subnets}"
  security_groups  = ["${module.rds-postgres-sg.sg_id}"]
  multi_az         = false
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}



module "aurora_postgres_setup" {
  source             = "../../modules/aurora-postgres"
  cluster_identifier = "scrapers-cluster"
  name               = "sdao-scrapers-db"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  instance_class     = "db.r5.large"
  engine_version     = "13.4"
  #instance_engine_version = "10.7"
  #replica_count       = 0
  instance_identifier = "sdao-scrapers-db-prod"
  database_name       = "sdao_scraper_db"
  master_username     = "sdao_scraper_db_admin"
  master_password     = "${var.db_password_2}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}


module "aurora_postgres_setup_kucoin" {
  source             = "../../modules/aurora-postgres"
  cluster_identifier = "kucoin-cluster"
  name               = "kucoin-scrapers-db"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  instance_class     = "db.t3.medium"
  engine_version     = "13.4"
  #instance_engine_version = "10.7"
  #replica_count       = 0
  instance_identifier = "kucoin-scrapers-db-prod"
  database_name       = "kucoin_scraper_db"
  master_username     = "kucoin_scraper_db_admin"
  master_password     = "${var.db_password_3}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}




module "aurora_postgres_setup_deribit" {
  source             = "../../modules/aurora-postgres"
  cluster_identifier = "deribit-cluster"
  name               = "deribit-scrapers-db"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  instance_class     = "db.t3.medium"
  engine_version     = "13.4"
  #instance_engine_version = "10.7"
  #replica_count       = 0
  instance_identifier = "deribit-scrapers-db-prod"
  database_name       = "deribit_scraper_db"
  master_username     = "deribit_scraper_db_admin"
  master_password     = "${var.db_password_4}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}



module "aurora_postgres_setup_exchange" {
  source             = "../../modules/aurora-postgres"
  cluster_identifier = "exchange-data-cluster"
  name               = "exchange-data-scrapers-db"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  instance_class     = "db.t3.medium"
  engine_version     = "13.4"
  #instance_engine_version = "10.7"
  #replica_count       = 0
  instance_identifier = "exchange-data-scrapers-db-prod"
  database_name       = "exchange_data_scraper_db"
  master_username     = "exchange_data_scraper_db_admin"
  master_password     = "${var.db_password_6}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  #enabled_cloudwatch_logs_exports = "postgresql"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}


module "aurora_postgres_setup_binance" {
  source             = "../../modules/aurora-postgres"
  cluster_identifier = "binance-cluster"
  name               = "binance-scrapers-db"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  instance_class     = "db.r5.large"
  engine_version     = "13.4"
  #instance_engine_version = "10.7"
  #replica_count       = 0
  instance_identifier = "binance-scrapers-db-prod"
  database_name       = "binance_scraper_db"
  master_username     = "binance_scraper_db_admin"
  master_password     = "${var.db_password_7}"
  db_subnet_ids       = "${module.vpc.private_subnets}"
  security_groups     = ["${module.rds-sg.sg_id}"]
  #enabled_cloudwatch_logs_exports = "postgresql"
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "rds_ai_mysql_setup" {
  source           = "../../modules/rds"
  storage_size     = 50
  storage_type     = "gp2"
  db_type          = "mysql"
  db_version       = "8.0"
  db_instance_type = "db.t3.medium"
  name             = "sdao-ai-prod-db"
  db_name          = "sdao_ai_db_prod"
  db_username      = "sdao_ai_db_prod_admin"
  db_password      = "${var.db_password_8}"
  db_subnet_ids    = "${module.vpc.private_subnets}"
  security_groups  = ["${module.rds-sg.sg_id}"]
  multi_az         = false
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "rds_ai_mysql_setup_2" {
  source           = "../../modules/rds"
  storage_size     = 200
  storage_type     = "gp2"
  db_type          = "mysql"
  db_version       = "8.0"
  db_instance_type = "db.t3.medium"
  name             = "sdao-ai-prod-db-2"
  db_name          = "sdao_ai_db_prod_2"
  db_username      = "sdao_ai_db_prod_2_admin"
  db_password      = "${var.db_password_9}"
  db_subnet_ids    = "${module.vpc.private_subnets}"
  security_groups  = ["${module.rds-sg.sg_id}"]
  multi_az         = false
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}
