variable "region" {
  default = ""
}
variable "profile" {
  default = ""
}
provider "aws" {
  region  = var.region
  profile = var.profile
}
