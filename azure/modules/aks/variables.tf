variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

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
  description = "Azure region where to create resources"
}


### AKS configuration params ###
variable "kubernetes_version" {
  type = string
  description = "Version of your kubernetes node pool"
}

variable "vm_size_node_pool" {
  type = string
  description = "VM Size of your node pool"
}

variable "node_pool_min_count" {
  type = string
  description = "VM minimum amount of nodes for your node pool"
}

variable "node_pool_max_count" {
  type = string
  description = "VM maximum amount of nodes for your node pool"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network name. This service will create subnets in this network."
}