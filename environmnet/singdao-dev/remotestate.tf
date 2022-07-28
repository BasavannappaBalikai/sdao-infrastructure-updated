terraform {
  backend "s3" {
    bucket  = "singdao-config-dev"
    key     = "sdao-infra/tf-state"
    region  = "eu-west-1"
    profile = "singdao"
  }
}
