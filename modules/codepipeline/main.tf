variable "name" {
  default = ""
}


variable "repository_owner" {
  default = ""
}

variable "repository_name" {
  default = ""
}

variable "branch" {
  default = ""
}

variable "project_name" {
  default = ""
}

variable "github_oauth_token" {
  default = ""
}

variable "role_arn" {
  default = ""
}

variable "location" {
  default = ""
}

variable "codebuild_project_name" {
  default = ""
}

variable "cluster_name" {
  default = ""
}

variable "service_name" {
  default = ""
}

resource "aws_codepipeline" "codepipeline" {
  name     = var.name
  role_arn = var.role_arn

  artifact_store {
    location = var.location
    type     = "S3"


  }


  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = var.repository_owner
        Repo       = var.repository_name
        Branch     = var.branch
        OAuthToken = var.github_oauth_token
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName   = var.codebuild_project_name
        PrimarySource = "Source"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = 1
      run_order       = 1
      input_artifacts = ["build_output"]

      configuration = {
        ClusterName = var.cluster_name
        ServiceName = var.service_name
        FileName    = "imagedefinitions.json"
      }
    }
  }

}
