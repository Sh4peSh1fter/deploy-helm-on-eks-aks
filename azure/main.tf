module "rg" {
  source = "./modules/rg"

  name     = "rg-${var.env}"
  location = var.location
  env      = var.env
}

module "vnet" {
  source = "./modules/vnet"

  name                = "vnet-${var.env}"
  location            = var.location
  env                 = var.env
  resource_group_name = module.rg.name
}

module "aks" {
  source = "./modules/aks"

  name                = "aks-${var.env}"
  location            = var.location
  env                 = var.env
  resource_group_name = module.rg.name
  vnet_id             = module.vnet.id

  ## subnet vars
  virtual_network_name = module.vnet.name

  ## AKS nodes vars
  kubernetes_version  = var.kubernetes_version
  vm_size_node_pool   = var.vm_size_node_pool
  node_pool_min_count = var.node_pool_min_count
  node_pool_max_count = var.node_pool_max_count
  os_disk_size        = var.os_disk_size
}

module "ag" {
  source = "./modules/ag"

  name                 = "ag-${var.env}"
  location             = var.location
  env                  = var.env
  resource_group_name  = module.rg.name
  virtual_network_name = module.vnet.name
}

module "apps" {
  source = "./modules/apps"

  name       = "app-${var.env}"
  env        = var.env
  aks_config = module.aks.aks_config
}
