data "aws_ami" "image" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.image_name]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.image_owners]
}

variable "image_owners" {
  default = ""
}

variable "image_name" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "subnet" {
  type    = list
  default = []
}

variable "subnet_count" {
  default = ""
}

variable "public_ip" {
  default = ""
}

variable "iam_instance_profile" {
  default = ""
}

variable "key_name" {
  default = ""
}

variable "security_groups" {
  type    = list
  default = []
}

variable "root_volume" {
  default = ""
}

variable "tags" {
  type    = map
  default = {}
}

resource "aws_instance" "ec2_instance" {
  ami                         = "${data.aws_ami.image.id}"
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet, var.subnet_count)
  associate_public_ip_address = var.public_ip
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name
  vpc_security_group_ids      = var.security_groups
  tags                        = var.tags
  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_volume
    delete_on_termination = true
  }
  lifecycle {
    ignore_changes = [
      ami
    ]
  }
}

output "instance_id" {
  value = "${aws_instance.ec2_instance.id}"
}
