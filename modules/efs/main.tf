variable "efs_file_system_name" {
  default = ""
}

resource "aws_efs_file_system" "sdao_efs" {
  creation_token = var.efs_file_system_name
  encrypted      = true
  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

