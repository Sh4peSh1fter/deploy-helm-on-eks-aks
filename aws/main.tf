module "vpc" {
  source = "./modules/vpc"

  name  = "vpc-eks-${var.env}"
} 

module "eks" {
  source = "./modules/eks"

  name  = "eks-${var.env}"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

module "alb" {
  source = "./modules/alb"

  name      = "alb-${var.env}"
  env       = var.env
  location  = var.location
  vpc_id    = module.vpc.vpc_id
  eks_cluster_id = module.eks.eks_cluster_id
  iam_role_arn = ""
  oidc_provider_arn = ""
}