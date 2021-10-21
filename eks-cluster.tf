module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version
  subnets         = module.vpc.public_subnets

  tags = {
    Environment = "DefenseUnicorns-Dev"
    GithubOrg   = "defenseunicorns"
  }

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "m5.xlarge"
      additional_userdata           = "sysctl -w vm.max_map_count=262144"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "m5.2xlarge"
      additional_userdata           = "sysctl -w vm.max_map_count=262144"
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      asg_desired_capacity          = 1
    },
  ]

  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  map_users                            = var.map_users
  map_roles                            = var.map_roles
  write_kubeconfig                     = var.write_kubeconfig
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
