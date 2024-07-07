variable "env" {
  type        = string
  default     = "dev"
  description = "Environment"
}

variable "location" {
  type        = string
  description = "Azure region for the resources creation"
  default     = "West US 2" # if speed doesnt metter too muc, you should pick by price (the cheapest) - https://cloudprice.net/regions
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version of the node pool"
  default     = "1.27.9"
}

variable "vm_size_node_pool" {
  type        = string
  description = "Node pool VM size"
  default     = "standard_d2_v2" # choose the size that fits your needs with it's resources (CPU and RAM). prices can be seen here - https://cloudprice.net/
}

variable "node_pool_min_count" {
  type        = string
  description = "Minimum amount of nodes for the node pool"
  default     = 2
}

variable "node_pool_max_count" {
  type        = string
  description = "Maximum amount of nodes for the node pool"
  default     = 3
}

variable "os_disk_size" {
  type        = string
  description = "Node pool VM os disk size in GB"
  default     = 30
}
