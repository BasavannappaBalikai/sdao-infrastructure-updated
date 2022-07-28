module "bastion_host_setup" {
  source               = "../../modules/ec2"
  instance_type        = "t2.micro"
  subnet               = "${module.vpc.public_subnets}"
  subnet_count         = 1
  public_ip            = true
  iam_instance_profile = "${module.bastion_instance_profile.iam_instance_profile}"
  key_name             = "sdao-key-pair-uat"
  security_groups      = ["${module.bastion-sg.sg_id}"]
  root_volume          = "20"
  image_name           = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  image_owners         = "099720109477"
  tags = {
    Name        = "bastion-uat"
    Terraform   = "True"
    Environment = "UAT"
    Project     = "Singularity DAO"
  }
}
