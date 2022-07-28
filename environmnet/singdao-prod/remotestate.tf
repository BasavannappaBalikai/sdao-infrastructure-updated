terraform {
  backend "s3" {
    bucket  = "singdao-config-prod"
    key     = "sdao-infra/tf-state"
    region  = "eu-west-1"
    profile = "singdao"
  }
}
