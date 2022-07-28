module "scheduler_setup" {
  source               = "../../modules/ec2"
  instance_type        = "t2.micro"
  subnet               = "${module.vpc.public_subnets}"
  subnet_count         = 1
  public_ip            = true
  iam_instance_profile = "${module.bastion_instance_profile.iam_instance_profile}"
  key_name             = "sdao-key-pair-prod"
  security_groups      = ["${module.bastion-sg.sg_id}"]
  root_volume          = "20"
  image_name           = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  image_owners         = "099720109477"
  tags = {
    Name        = "bastion-prod"
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}

module "sdao_ai_instance" {
  source          = "../../modules/ec2"
  instance_type   = "t3.2xlarge"
  subnet          = "${module.vpc.public_subnets}"
  subnet_count    = 1
  public_ip       = true
  key_name        = "sdao-ai-keypair"
  security_groups = ["${module.sdao-ai-ec2-instance-sg.sg_id}"]
  root_volume     = "500"
  image_name      = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  image_owners    = "099720109477"
  tags = {
    Name        = "sdao-ec2-ai-instance"
    Terraform   = "True"
    Environment = "PROD"
    Project     = "Singularity DAO"
  }
}
