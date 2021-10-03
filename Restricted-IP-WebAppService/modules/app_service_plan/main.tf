resource "azurerm_app_service_plan" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  kind     = var.os_type
  reserved = true

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}