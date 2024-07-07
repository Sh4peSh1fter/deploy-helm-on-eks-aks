output "name" {
  value       = azurerm_application_gateway.ag.name
  description = "Name of the Application Gateway used by AKS"
}

output "ag_fqdn" {
  value       = azurerm_public_ip.ag_pip.fqdn
  description = "FQDN of the Application Gateway / AKS Cluster."
}
