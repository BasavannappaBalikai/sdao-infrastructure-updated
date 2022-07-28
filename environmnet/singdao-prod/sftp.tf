module "sftp-server" {
  source   = "../../modules/sftp"
  role_arn = "arn:aws:iam::925884611165:role/sdao-sftp-role"
  tags = {
    Name        = "sdao-sftp-server"
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}
