resource "azurerm_resource_group" "main" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_subnet" "main" {
  name                 = var.subnet_name
  resource_group_name  = var.main_rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_cidr

  service_endpoints = ["Microsoft.KeyVault"]

  delegation {
    name = "appservice_delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

data "azurerm_key_vault" "global" {
  name                = var.main_keyvault_name
  resource_group_name = var.main_rg_name
} 
module "action_group" {
   source              = "../modules/monitor/action_group/"
   name                = var.actiongroup_name
   shortname           = var.actiongroup_shortname
   resource_group_name = azurerm_resource_group.main.name
}
