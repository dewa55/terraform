resource "azurerm_storage_account" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  account_kind             = "StorageV2"
  account_tier             = var.account_tier
  account_replication_type = var.replication
  access_tier              = var.access_tier

  min_tls_version = "TLS1_2"

  blob_properties {
    last_access_time_enabled = var.blob_last_access_time
    versioning_enabled       = var.blob_versioning
    delete_retention_policy {
      days = var.blob_delete_retention
    }
    container_delete_retention_policy {
      days = var.container_delete_retention
    }

    dynamic "cors_rule" {
      for_each = var.cors_rules
      content {
        allowed_origins    = cors_rule.value.allowed_origins
        allowed_methods    = cors_rule.value.allowed_methods
        allowed_headers    = cors_rule.value.allowed_headers
        exposed_headers    = cors_rule.value.exposed_headers
        max_age_in_seconds = cors_rule.value.max_age_in_seconds
      }
    }
  }

  share_properties {
    dynamic "cors_rule" {
      for_each = var.cors_rules
      content {
        allowed_origins    = cors_rule.value.allowed_origins
        allowed_methods    = cors_rule.value.allowed_methods
        allowed_headers    = cors_rule.value.allowed_headers
        exposed_headers    = cors_rule.value.exposed_headers
        max_age_in_seconds = cors_rule.value.max_age_in_seconds
      }
    }

  }

  tags = var.tags
}

resource "azurerm_storage_container" "main" {
  for_each              = var.containers
  name                  = each.key
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = each.value
}

resource "azurerm_storage_queue" "main" {
  for_each             = var.queues
  name                 = each.value
  storage_account_name = azurerm_storage_account.main.name
}

resource "azurerm_storage_table" "main" {
  for_each             = var.tables
  name                 = each.value
  storage_account_name = azurerm_storage_account.main.name
}

###
# Lock storage to avoid accidental removal
###
resource "azurerm_management_lock" "storage_account" {
  name       = var.name
  scope      = resource.azurerm_storage_account.main.id
  lock_level = "CanNotDelete"
  notes      = "Locked to avoid accidental removal"
}
