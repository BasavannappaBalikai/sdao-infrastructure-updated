variable "name" {
  default = ""
}

variable "deployment_group_name" {
  default = ""
}

variable "service_role_arn" {
  default = ""
}

variable "cluster_name" {
  default = ""
}

variable "service_name" {
  default = ""
}


variable "listener_arns" {
  default = ""
}

variable "alb_target_name" {
  default = ""
}

variable "target_group_1" {
  default = ""
}

variable "target_group_2" {
  default = ""
}


resource "aws_codedeploy_app" "example" {
  compute_platform = "ECS"
  name             = var.name
}

resource "aws_codedeploy_deployment_group" "example" {
  app_name               = aws_codedeploy_app.example.name
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  deployment_group_name  = var.deployment_group_name
  service_role_arn       = var.service_role_arn

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }

    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = var.cluster_name
    service_name = var.service_name
  }


  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.listener_arns]
      }

      target_group {
        name = var.target_group_1
      }

      target_group {
        name = var.target_group_2
      }
    }
  }

}
