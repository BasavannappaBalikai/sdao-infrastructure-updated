variable "name" {
  type    = list
  default = []
}

variable "image_name" {
  default = ""
}


variable "environment" {
  default = ""
}

variable "config_bucket" {
  default = ""
}

variable "target_bucket" {
  default = ""
}

variable "vpc_id" {
  default = ""
}

variable "subnets" {
  type    = list
  default = []
}

variable "security_group_ids" {
  type    = list
  default = []
}

variable "role_arn" {
  default = ""
}

variable "location" {
  default = ""
}

variable "branch" {
  default = ""
}

variable "cache_type" {
  default = ""
}

variable "cache_modes" {
  type    = list
  default = []
}

variable "cache_location" {
  default = ""
}

variable "tags" {
  default = ""
}

variable "NODE_ENV" {
  default = ""
}

variable "NODE_OPTIONS" {
  default = ""
}

variable "image_pull_credentials_type" {
  default = ""
}


resource "aws_codebuild_project" "codebuild" {
  count         = length(var.name)
  name          = element(var.name, count.index)
  description   = ""
  build_timeout = "60"
  service_role  = var.role_arn



  environment {
    compute_type    = "BUILD_GENERAL1_MEDIUM"
    image           = var.image_name
    type            = "LINUX_CONTAINER"
    privileged_mode = true
    #image_pull_credentials_type = "SERVICE_ROLE"
    image_pull_credentials_type = var.image_pull_credentials_type

    environment_variable {
      name  = "environment"
      value = var.environment
    }

    environment_variable {
      name  = "config_bucket"
      value = var.config_bucket
    }

    environment_variable {
      name  = "target_bucket"
      value = var.target_bucket
    }

    environment_variable {
      name  = "NODE_OPTIONS"
      value = var.NODE_OPTIONS
    }

    environment_variable {
      name  = "NODE_ENV"
      value = var.NODE_ENV
    }

  }


  /*cache {
    type = "NO_CACHE"
    #modes = ["LOCAL_CUSTOM_CACHE", "LOCAL_SOURCE_CACHE"]
  }*/


  cache {
    type     = var.cache_type
    modes    = var.cache_modes
    location = var.cache_location
  }
  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.subnets
    security_group_ids = var.security_group_ids
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

  source {
    type            = "GITHUB"
    location        = var.location
    buildspec       = file("${path.module}/templates/${element(var.name, count.index)}")
    git_clone_depth = 1
  }

  source_version = var.branch

  tags = var.tags
}
