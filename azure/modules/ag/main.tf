# Subnet
resource "azurerm_subnet" "ag_snet" {
  name                 = "subnet-ag-${var.env}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.2.0/24"]
}

# Public IP
resource "azurerm_public_ip" "ag_pip" {
  name                = "pip-${var.env}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

locals {
  backend_address_pool_name      = "be-ap-${var.virtual_network_name}"
  frontend_port_name             = "fe-port-${var.virtual_network_name}"
  frontend_ip_configuration_name = "fe-ipconf-${var.virtual_network_name}"
  http_setting_name              = "be-http-setting-${var.virtual_network_name}"
  http_listener_name             = "http-lstn-${var.virtual_network_name}"
  request_routing_rule_name      = "rq-routing-rule-${var.virtual_network_name}"
}

# Application Gateway
resource "azurerm_application_gateway" "ag" {
  # depends_on = [azurerm_kubernetes_cluster.aks]

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "ag-ip-config"
    subnet_id = azurerm_subnet.ag_snet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.ag_pip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = local.http_listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.http_listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   = 1
  }

  tags = {
    environment = var.env
  }
}
