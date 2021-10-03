output "id" {
  value = azurerm_app_service.main.id
}
output "principal_id" {
  value = azurerm_app_service.main.identity.0.principal_id
}