variable "cluster_identifier" {}
variable "name" {}
variable "engine" {}
variable "database_name" {}
variable "master_username" {}
variable "docdb_password" {}
variable "instance_class" {}
variable "security_groups" {}
variable "db_subnet_ids" {}
variable "instance_identifier" {}
variable "tags" {}



resource "aws_docdb_subnet_group" "userdb_subnet_group" {
  name       = var.name
  subnet_ids = var.db_subnet_ids

}

resource "aws_docdb_cluster_parameter_group" "example" {
  family      = "docdb3.6"
  name        = var.name
  description = "docdb cluster parameter group"
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = var.instance_identifier
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = var.instance_class

}


resource "aws_docdb_cluster" "docdb" {
  cluster_identifier     = var.cluster_identifier
  engine                 = var.engine
  master_username        = var.master_username
  master_password        = var.docdb_password
  db_subnet_group_name   = "${aws_docdb_subnet_group.userdb_subnet_group.name}"
  vpc_security_group_ids = var.security_groups
  skip_final_snapshot    = true
  tags                   = var.tags
}
