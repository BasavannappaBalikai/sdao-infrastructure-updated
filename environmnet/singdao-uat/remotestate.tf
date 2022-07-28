terraform {
  backend "s3" {
    bucket = "singdao-config-uat"
    key    = "sdao-infra/tf-state"
    region = "eu-west-1"
  }
}
