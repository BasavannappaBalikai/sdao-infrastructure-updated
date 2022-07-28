variable "service_name" {
  type    = "list"
  default = []
}

variable "cluster_id" {
  default = ""
}

variable "task_definition_arn" {
  type    = "list"
  default = []
}

variable "desired_count" {
  type    = "list"
  default = []
}

#variable "ecs_role" {
#  default = ""
#}

variable "launch_type" {
  default = ""
}

variable "target_arns" {
  type    = "list"
  default = []
}

variable "container_port" {
  type    = "list"
  default = []
}

variable "subnets" {
  type    = "list"
  default = []
}

variable "ecs_sg" {
  type    = "list"
  default = []
}

variable "type" {
  default = ""
}

variable "container_name" {
  default = ""
}


resource "aws_ecs_service" "ecs_service" {
  count           = length(var.service_name)
  name            = element(var.service_name, count.index)
  cluster         = var.cluster_id
  task_definition = element(var.task_definition_arn, count.index)
  desired_count   = element(var.desired_count, count.index)
  #iam_role                           = var.ecs_role
  launch_type                        = var.launch_type
  force_new_deployment               = false
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200



  load_balancer {
    target_group_arn = element(var.target_arns, count.index)
    container_name   = var.container_name
    container_port   = element(var.container_port, count.index)
  }


  deployment_controller {
    type = var.type
  }

  lifecycle {
    ignore_changes = [
      force_new_deployment,
      task_definition
    ]
  }

  network_configuration {
    subnets         = var.subnets
    security_groups = var.ecs_sg
  }
}
