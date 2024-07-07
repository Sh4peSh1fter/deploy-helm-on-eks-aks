variable "name" {
  type        = string
  description = "name"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group"
}

variable "location" {
  type        = string
  description = "Azure region where to create resources."
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network name. This service will create subnets in this network."
}
