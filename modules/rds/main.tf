variable "storage_size" {
  default = ""
}

variable "storage_type" {
  default = ""
}

variable "db_type" {
  default = ""
}

variable "db_version" {
  default = ""
}

variable "db_instance_type" {
  default = ""
}

variable "name" {
  default = ""
}

variable "db_name" {
  default = ""
}

variable "db_username" {
  default = ""
}

variable "db_password" {
  default = ""
}

variable "db_subnet_ids" {
  type    = list
  default = []
}

variable "security_groups" {
  type        = list
  description = "Get the list of security group ids"
  default     = [""]
}

variable "tags" {
  type    = map
  default = {}
}

variable "multi_az" {
  default = ""
}

resource "aws_db_subnet_group" "userdb_subnet_group" {
  name        = var.name
  description = "subnet group for mysql"
  subnet_ids  = var.db_subnet_ids
}

resource "aws_db_parameter_group" "default" {
  name   = var.name
  family = "mysql8.0"
}

resource "aws_db_instance" "mysql-db" {
  allocated_storage      = var.storage_size
  storage_type           = var.storage_type
  engine                 = var.db_type
  engine_version         = var.db_version
  instance_class         = var.db_instance_type
  name                   = var.db_name
  identifier             = var.name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = "${aws_db_subnet_group.userdb_subnet_group.name}"
  parameter_group_name   = "${aws_db_parameter_group.default.id}"
  vpc_security_group_ids = var.security_groups
  skip_final_snapshot    = true
  tags                   = var.tags
  multi_az               = var.multi_az
}
