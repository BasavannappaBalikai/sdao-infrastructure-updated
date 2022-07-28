variable "region" {
  default = ""
}

provider "aws" {
  region = var.region
}
