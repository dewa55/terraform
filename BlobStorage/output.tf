output "primary_access_key" {
  value     = azurerm_storage_account.main.primary_access_key
  sensitive = true
}

output "primary_connection_string" {
  value     = azurerm_storage_account.main.primary_connection_string
  sensitive = true
}

output "id" {
  value     = azurerm_storage_account.main.id
  sensitive = true
}

output "name" {
  value     = azurerm_storage_account.main.name
  sensitive = true
}
