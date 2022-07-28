module "eks_custer" {
  source       = "../../modules/eks-cluster"
  cluster_name = "elt-staging-eks-cluster"
  #subnet       = "[${module.vpc.private_subnets},${module.vpc.public_subnets}]"
  public_subnets  = "${module.vpc.public_subnets}"
  private_subnets = "${module.vpc.private_subnets}"
  disk_size       = 20
  instance_types  = ["t3.medium"]
  ec2_ssh_key     = "ec2-key-pair"


  tags = {
    Name        = "elt-staging-eks-cluster"
    Terraform   = "True"
    Environment = "DEV"
    Project     = "Singularity DAO"
  }
}
