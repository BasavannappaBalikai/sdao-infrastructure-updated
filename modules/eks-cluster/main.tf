variable "cluster_name" {
  default = ""
}
variable "public_subnets" {
  type    = list
  default = []
}

variable "private_subnets" {
  type    = list
  default = []
}

variable "instance_types" {
  type    = list
  default = []
}

variable "disk_size" {
  default = ""
}

variable "ec2_ssh_key" {
  default = ""
}
variable "tags" {

}

resource "aws_eks_cluster" "cluster" { # Here we create the EKS cluster itself.
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn # The cluster needs an IAM role to gain some permission over your AWS account
  tags     = var.tags

  vpc_config {

    subnet_ids              = concat(var.public_subnets, var.private_subnets) # We pass all 6 subnets (public and private ones). Retrieved from the AWS module before.
    endpoint_public_access  = true                                            # The cluster will have a public endpoint. We will be able to call it from the public internet.
    endpoint_private_access = true
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"] # We enable control plane components logging against Amazon Cloudwatch log group. 

  # Ensure that IAM Role permissions are handled before the EKS Cluster.
  depends_on = [
    aws_iam_role_policy_attachment.policy-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.policy-AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.eks_cluster_control_plane_components
  ]
}

resource "aws_iam_role" "eks_cluster" {
  name = "${var.cluster_name}_role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "policy-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "policy-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_cloudwatch_log_group" "eks_cluster_control_plane_components" { # To log control plane components
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7
}

resource "null_resource" "generate_kubeconfig" { # Generate a kubeconfig (needs aws cli >=1.62 and kubectl)

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name}"
  }

  depends_on = [aws_eks_cluster.cluster]
}

data "tls_certificate" "cluster" {
  url = aws_eks_cluster.cluster.identity.0.oidc.0.issuer
}

resource "aws_iam_openid_connect_provider" "cluster" { # We need an open id connector to allow our service account to assume an IAM role
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = concat([data.tls_certificate.cluster.certificates.0.sha1_fingerprint], [])
  url             = aws_eks_cluster.cluster.identity.0.oidc.0.issuer
}


############

# Step 6: Adding the worker nodes + CNI + Kubernetes Cluster Autoscaler
resource "null_resource" "install_calico" { # The node won't enter the ready state without a CNI initialized
  provisioner "local-exec" {
    command = "kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml"
  }

  depends_on = [null_resource.generate_kubeconfig]
}

data "template_file" "aws_auth_configmap" { # Generates the aws-auth, otherwise, worker node can't join. Use this cm to add users/role to your cluster

  template = file("${path.module}/templates/aws-auth-cm.yaml.tpl")

  vars = {
    arn_instance_role = aws_iam_role.node_group.arn
  }
}

resource "null_resource" "apply_aws_auth_configmap" { # Apply the aws-auth config map

  provisioner "local-exec" {
    command = "echo '${data.template_file.aws_auth_configmap.rendered}' > aws-auth-cm.yaml && kubectl apply -f aws-auth-cm.yaml && rm aws-auth-cm.yaml"
  }


  depends_on = [null_resource.generate_kubeconfig]
}

resource "aws_eks_node_group" "node_group" { # One node group per AZ (each AZ has its own private subnet)
  count = length(var.private_subnets)

  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "subnet-${substr(var.private_subnets[count.index], 7, length(var.private_subnets[count.index]))}-group"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = [var.private_subnets[count.index]]
  instance_types  = var.instance_types
  disk_size       = var.disk_size

  scaling_config {
    desired_size = 1
    max_size     = 5
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key = "jenkins-eks-key-pair"
  }

  depends_on = [null_resource.apply_aws_auth_configmap]
}

resource "aws_iam_role" "node_group" {
  name = "eks_node_group_role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "policy-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "policy-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

