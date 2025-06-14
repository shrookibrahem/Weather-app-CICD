module "vpc" {
    source = "./vpc-module"
    vpc-cidr = var.vpc-cidr-block
    privsub-cidr = var.privsub-cidr-block
    pubsub-cidr =  var.pubsub-cidr-block
    avilability_zones = var.avilability_zones-Name
    cluster-name = var.cluster-name-e
    
}


data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

resource "aws_eks_cluster" "otel_cluster" {
  name    = "otel-Cluster"
  role_arn = data.aws_iam_role.lab_role.arn
  version  = "1.29"

  vpc_config {
    subnet_ids = module.vpc.private-subnets
  }
}

resource "aws_eks_node_group" "otel_nodes" {
  cluster_name    = aws_eks_cluster.otel_cluster.name
  node_group_name = "otel-Cluster-nodes"
  node_role_arn   = data.aws_iam_role.lab_role.arn
  subnet_ids      = module.vpc.private-subnets
  instance_types  = ["t3.medium"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 2
  }
  update_config {
    max_unavailable = 1
  }
  tags = {
    Name = "EKS_Nodes"
  }
}
