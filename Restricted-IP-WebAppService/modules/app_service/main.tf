resource "azurerm_app_service" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id

  identity {
    type = "SystemAssigned"
  }

  https_only = var.https_only

  site_config {
    always_on        = true
    ftps_state       = "Disabled"
    linux_fx_version = var.linux_fx_version
    app_command_line = var.startup_command
    ip_restriction   = local.ip_restriction
  }

  app_settings = var.app_settings
}
