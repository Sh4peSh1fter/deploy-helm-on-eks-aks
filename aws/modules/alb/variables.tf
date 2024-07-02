variable "name" {
  type        = string
  description = "name"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "location" {
  type        = string
}

variable "vpc_id" {
  type        = string
}

variable "eks_cluster_id" {
  type        = string
}

variable "iam_role_arn" {
  type        = string
}

variable "oidc_provider_arn" {
  type        = string
}
