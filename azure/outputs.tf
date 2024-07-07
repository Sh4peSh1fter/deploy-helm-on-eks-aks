# General
output "location" {
  value       = var.location
  description = "Location of all the resources"
}

# Resource Group
output "rg_name" {
  value       = module.rg.name
  description = "Resource Group name"
}

# Virtual Network
output "vnet_name" {
  value       = module.vnet.name
  description = "Virtual Network name"
}

# AKS
output "aks_name" {
  value       = module.aks.name
  description = "AKS cluster name"
}

# Application Gateway
output "ag_name" {
  value       = module.ag.name
  description = "Application Gateway name"
}
