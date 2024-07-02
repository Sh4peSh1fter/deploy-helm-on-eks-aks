variable "env" {
  type        = string
  default     = "dev"
  description = ""
}

variable "location" {
  type        = string
  description = "AWS region where to create resources."
  default     = "US East"
}

variable "vm_size_node_pool" {
  type        = string
  description = "VM Size of the node pool"
  default     = "standard_d2_v2"
}

variable "node_pool_min_count" {
  type        = string
  description = "VM minimum amount of nodes for the node pool"
  default     = 2
}

variable "node_pool_max_count" {
  type        = string
  description = "VM maximum amount of nodes for the node pool"
  default     = 3
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version of the node pool"
  default     = "1.27.9"
}