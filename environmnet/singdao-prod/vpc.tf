module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "2.33.0"
  name               = "singdao-prod"
  cidr               = "20.0.0.0/16"
  single_nat_gateway = true
  azs                = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets    = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
  public_subnets     = ["20.0.101.0/24", "20.0.102.0/24", "20.0.103.0/24"]

  enable_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "main-rt-table" {
  source         = "../../modules/main-route-table"
  vpc_id         = "${module.vpc.vpc_id}"
  route_table_id = "${module.vpc.public_route_table_ids}"
}
