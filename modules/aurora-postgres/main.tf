variable "cluster_identifier" {}
variable "name" {}
variable "engine" {}
variable "engine_mode" {}
variable "engine_version" {}
variable "database_name" {}
variable "master_username" {}
variable "master_password" {}
variable "security_groups" {}
variable "db_subnet_ids" {}
#variable "instance_engine_version" {}
variable "instance_identifier" {}
variable "instance_class" {}
#variable "enabled_cloudwatch_logs_exports" {}
#variable "replica_count" {}
variable "tags" {}


/*
resource "aws_db_subnet_group" "userdb_subnet_group" {
  name        = var.name
  description = "subnet group for aurora postgres"
  subnet_ids  = var.db_subnet_ids
}


resource "aws_db_parameter_group" "aurora_postgres" {
  name   = var.name
  family = "postgres13"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = var.instance_identifier
  cluster_identifier = var.cluster_identifier
  instance_class     = var.instance_class
  engine_version     = var.engine_version
  #replica_count           = var.replica_count
  skip_final_snapshot     = true
  db_parameter_group_name = "${aws_db_parameter_group.aurora_postgres.name}"
}


resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_mode             = var.engine_mode
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = 5
  skip_final_snapshot     = true
  #db_subnet_group_name    = "${aws_db_subnet_group.userdb_subnet_group.name}"

}
*/



######

resource "aws_db_subnet_group" "userdb_subnet_group" {
  name        = var.name
  description = "subnet group for aurora postgres"
  subnet_ids  = var.db_subnet_ids
}

resource "aws_db_parameter_group" "example" {
  name        = var.name
  family      = "aurora-postgresql13"
  description = "aurora-db-postgres11-parameter-group"

}

resource "aws_rds_cluster_parameter_group" "example" {
  name        = var.name
  family      = "aurora-postgresql13"
  description = "aurora-postgres11-cluster-parameter-group"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = var.instance_identifier
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
  #monitoring_interval = 60
  lifecycle {
    ignore_changes = [
      monitoring_interval
    ]
  }

}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = var.cluster_identifier
  engine                  = var.engine
  engine_mode             = var.engine_mode
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  vpc_security_group_ids  = var.security_groups
  backup_retention_period = 5
  db_subnet_group_name    = "${aws_db_subnet_group.userdb_subnet_group.name}"
  skip_final_snapshot     = true
  #enabled_cloudwatch_logs_exports = ["postgresql"]
  tags = var.tags
  lifecycle {
    ignore_changes = [
      enabled_cloudwatch_logs_exports
    ]
  }
}
