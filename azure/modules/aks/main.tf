# Subnet
resource "azurerm_subnet" "aks_subnet" {
  name                 = "snet-aks-${var.env}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [var.vnet_id]
}

# AKS
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-${var.env}"
  # kubernetes_version  = var.kubernetes_version

  default_node_pool {
    # type                = "VirtualMachineScaleSets"
    name = "aksnp${var.env}" # this name cant have "-" according to the restrictions

    node_count      = var.node_pool_min_count
    vm_size         = var.vm_size_node_pool
    os_disk_size_gb = var.os_disk_size
    vnet_subnet_id  = azurerm_subnet.aks_subnet.id

    enable_auto_scaling = true
    min_count           = var.node_pool_min_count
    max_count           = var.node_pool_max_count
  }

  # This means that Azure will automatically create the required roles and permissions
  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true

  tags = {
    environment = var.env
  }
}
