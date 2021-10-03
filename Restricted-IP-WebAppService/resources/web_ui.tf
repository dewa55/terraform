// Setup App service
module "web_ui" {
  source = "../modules/app_service/"

  name                = var.web_ui_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = module.app_service_plan.app_service_plan_id

  linux_fx_version = "NODE|12-lts"
  startup_command  = "npx serve -s"
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = module.web_ui_ai.instrumentation_key
  }

  authorized_ips = [
    {
      "name" = "Infinum IP"
      "ip"   = "1.2.3.5/32"
    },

    {
      "name" = "AL IPs -gadovi"
      "ip"   = "1.2.3.7/32"
    }
  ]
}

// Connection to the main subnet
resource "azurerm_app_service_virtual_network_swift_connection" "web_ui" {
  app_service_id = module.web_ui.id
  subnet_id      = azurerm_subnet.main.id
}

// Application insights
module "web_ui_ai" {
  source = "../modules/application_insights/"

  name                = var.web_ui_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

// Key vault
module "web_ui_kv" {
  source = "../modules/key_vault/"

  name                = var.web_ui_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  app_principal_id  = module.web_ui.principal_id
  cicd_principal_id = var.cicd_principal_id

  subnet_id = [azurerm_subnet.main.id]
}

// Key vault secrets

resource "azurerm_key_vault_secret" "test" {
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = module.web_ui_kv.id
}

module "web_ui_monitor_app_service" {
  source = "../modules/monitor/monitor_app_service/"

  name                  = var.web_ui_name
  resource_group_name   = azurerm_resource_group.main.name
  app_id                = module.web_ui.id
  actiongroup_id        = module.action_group.id
  actiongroup_name      = var.actiongroup_name
  actiongroup_shortname = var.actiongroup_shortname
  #depends_on = [ module.action_group ]
}
