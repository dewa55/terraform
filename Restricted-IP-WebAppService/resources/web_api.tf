// Pull secrets from global keyvault
data "azurerm_key_vault_secret" "ApiCallUrlsTokenSecret" {
  name         = "WebApi-ApiCallUrlsTokenSecret"
  key_vault_id = data.azurerm_key_vault.global.id
}
data "azurerm_key_vault_secret" "BackendCredentialsApiKey" {
  name         = "WebApi-ApiCallUrlsTokenSecret"
  key_vault_id = data.azurerm_key_vault.global.id
}
data "azurerm_key_vault_secret" "BackendCredentialsApiSecret" {
  name         = "WebApi-BackendCredentialsApiSecret"
  key_vault_id = data.azurerm_key_vault.global.id
}
data "azurerm_key_vault_secret" "BackendCredentialsApiKeyTest" {
  name         = "WebApi-BackendCredentialsApiKeyTest"
  key_vault_id = data.azurerm_key_vault.global.id
}
data "azurerm_key_vault_secret" "BackendCredentialsApiSecretTest" {
  name         = "WebApi-BackendCredentialsApiSecretTest"
  key_vault_id = data.azurerm_key_vault.global.id
}

// Setup App service
module "web_api" {
  source = "../modules/app_service/"

  name                = var.web_api_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  app_service_plan_id = module.app_service_plan.app_service_plan_id

  linux_fx_version = "DOTNETCORE|3.1"
  startup_command  = null
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"    = module.web_api_ai.instrumentation_key
    "ApiCallUrls__ApiUrl"               = var.web_api_ApiUrl
    "ApiCallUrls__ApiUrlTest"           = var.web_api_ApiUrlTest
    "ApiCallUrls__TokenSecret"          = "@Microsoft.KeyVault(VaultName=${var.web_api_name};SecretName=ApiCallUrlsTokenSecret)"
    "BackendCredentials__ApiKey"        = "@Microsoft.KeyVault(VaultName=${var.web_api_name};SecretName=BackendCredentialsApiKey)"
    "BackendCredentials__ApiSecret"     = "@Microsoft.KeyVault(VaultName=${var.web_api_name};SecretName=BackendCredentialsApiSecret)"
    "BackendCredentials__ApiKeyTest"    = "@Microsoft.KeyVault(VaultName=${var.web_api_name};SecretName=BackendCredentialsApiKeyTest)"
    "BackendCredentials__ApiSecretTest" = "@Microsoft.KeyVault(VaultName=${var.web_api_name};SecretName=BackendCredentialsApiSecretTest)"
  }
}

// Connection to the main subnet
resource "azurerm_app_service_virtual_network_swift_connection" "web_api" {
  app_service_id = module.web_api.id
  subnet_id      = azurerm_subnet.main.id
}

// Application insights
module "web_api_ai" {
  source = "../modules/application_insights/"

  name                = var.web_api_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

// Key vault
module "web_api_kv" {
  source = "../modules/key_vault/"

  name                = var.web_api_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  app_principal_id  = module.web_api.principal_id
  cicd_principal_id = var.cicd_principal_id

  subnet_id = [azurerm_subnet.main.id]
}

// Key vault secrets
resource "azurerm_key_vault_secret" "ApiCallUrlsTokenSecret" {
  name         = "ApiCallUrlsTokenSecret"
  value        = data.azurerm_key_vault_secret.ApiCallUrlsTokenSecret.value
  key_vault_id = module.web_api_kv.id
}
resource "azurerm_key_vault_secret" "BackendCredentialsApiKey" {
  name         = "BackendCredentialsApiKey"
  value        = data.azurerm_key_vault_secret.BackendCredentialsApiKey.value
  key_vault_id = module.web_api_kv.id
}
resource "azurerm_key_vault_secret" "BackendCredentialsApiSecret" {
  name         = "BackendCredentialsApiSecret"
  value        = data.azurerm_key_vault_secret.BackendCredentialsApiSecret.value
  key_vault_id = module.web_api_kv.id
}
resource "azurerm_key_vault_secret" "BackendCredentialsApiKeyTest" {
  name         = "BackendCredentialsApiKeyTest"
  value        = data.azurerm_key_vault_secret.BackendCredentialsApiKeyTest.value
  key_vault_id = module.web_api_kv.id
}
resource "azurerm_key_vault_secret" "BackendCredentialsApiSecretTest" {
  name         = "BackendCredentialsApiSecretTest"
  value        = data.azurerm_key_vault_secret.BackendCredentialsApiSecretTest.value
  key_vault_id = module.web_api_kv.id
}

module "web_api_monitor_app_service" {
  source = "../modules/monitor/monitor_app_service/"

  name                = var.web_api_name
  resource_group_name = azurerm_resource_group.main.name
  app_id              = module.web_api.id
  actiongroup_id       = module.action_group.id
  actiongroup_name    = var.actiongroup_name
  actiongroup_shortname = var.actiongroup_shortname
  #depends_on = [ module.action_group ]
}