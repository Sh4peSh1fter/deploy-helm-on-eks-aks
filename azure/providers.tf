terraform {
    required_version = ">= 1.1.0"

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.110.0"
        }
        helm = {
            source = "hashicorp/helm"
            version = "2.14.0"
        }
    }
}

provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host                   = var.aks_config.host
    client_certificate     = base64decode(var.aks_config.client_certificate)
    client_key             = base64decode(var.aks_config.client_key)
    cluster_ca_certificate = base64decode(var.aks_config.cluster_ca_certificate)
  }
}