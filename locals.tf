locals {
  cluster_name = var.cluster_name != "" ? var.cluster_name : "aws-eks-${random_string.suffix.result}"
}