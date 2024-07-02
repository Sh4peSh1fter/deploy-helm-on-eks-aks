output "ag_fqdn" {
  value       = azurerm_public_ip.pip.fqdn
  description = "FQDN of the Application Gateway / AKS Cluster."
}

output "ag_name" {
  value       = azurerm_application_gateway.ag.name
  description = "Name of the Application Gateway used by AKS"
}