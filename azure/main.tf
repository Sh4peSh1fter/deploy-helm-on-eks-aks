module "rg" {
  source = "./modules/rg"

  name      = "rg-${var.env}"
  location  = var.location
} 

module "vnet" {
  source = "./modules/vnet"

  name                = "vnet-${var.env}"
  resource_group_name = module.rg.name
  location            = var.location
}

module "aks" {
  source = "./modules/aks"

  name                 = "aks-${var.env}"
  env                  = var.env
  resource_group_name  = module.rg.name
  location             = var.location

  ### AKS configuration params ###
  kubernetes_version  = var.kubernetes_version
  vm_size_node_pool   = var.vm_size_node_pool
  node_pool_min_count = var.node_pool_min_count
  node_pool_max_count = var.node_pool_max_count
  virtual_network_name = module.vnet.name
}

module "ag" {
  source = "./modules/ag"

  name                 = "ag-${var.env}"
  env                  = var.env
  resource_group       = { "name" : module.rg.name, "id" : module.rg.id }
  location             = var.location
  virtual_network_name = module.vnet.name
}

module "apps" {
  source = "./modules/apps"

  name = "app-${var.env}"
  env  = var.env
  aks_config = module.aks.aks_config
}

