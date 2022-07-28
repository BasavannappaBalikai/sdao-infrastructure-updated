variable "ecsTaskExecutionRole" {
  default = ""
}

variable "task_definition" {
  type    = "list"
  default = []
}

variable "requires_compatibilities" {
  type    = "list"
  default = []
}

variable "cpu" {
  type    = "list"
  default = []
}

variable "memory" {
  type    = "list"
  default = []
}

variable "network_mode" {
  default = ""
}

variable "environment" {
  default = ""
}

resource "aws_ecs_task_definition" "service" {
  count                    = length(var.task_definition)
  family                   = "${element(var.task_definition, count.index)}-task-definition"
  container_definitions    = file("${path.module}/task-definitions/${var.environment}/${element(var.task_definition, count.index)}.json")
  requires_compatibilities = var.requires_compatibilities
  cpu                      = "${element(var.cpu, count.index)}"
  memory                   = "${element(var.memory, count.index)}"
  network_mode             = var.network_mode
  execution_role_arn       = var.ecsTaskExecutionRole
  task_role_arn            = var.ecsTaskExecutionRole
}

output "task_definition_arn" {
  value = "${aws_ecs_task_definition.service[*].id}"
}
