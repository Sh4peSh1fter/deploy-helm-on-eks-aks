output "rg_name" {
  value       = module.rg.name
  description = "Name of the Resource Group"
}

output "rg_location" {
  value       = module.rg.location
  description = "Location of the Resource Group"
}

output "vnet_name" {
  value       = module.vnet.name
  description = "Name of the Virtual Network"
}

output "aks_name" {
  value       = module.aks.aks_name
  description = "Name of the AKS cluster"
}

output "ag_name" {
  value       = module.ag.ag_name
  description = "Name of the Application Gateway used by AKS"
}

output "ag_fqdn" {
  value       = module.ag.ag_fqdn
  description = "FQDN of the Application Gateway"
}