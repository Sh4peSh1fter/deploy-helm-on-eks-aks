module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.3" # 20.15.0

  cluster_name    = var.name
  cluster_version = "1.26"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  
  subnet_ids  = var.private_subnets
  vpc_id      = var.vpc_id

  eks_managed_node_groups = {
    nodes = {
      desired_capacity = 1
      min_capacity     = 1
      max_capacity     = 2

      instance_type = "t3.medium" # "m5.large"
    }
  }
}