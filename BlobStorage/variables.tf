variable "name" {
  description = "Name of the storage account"
  type        = string
}

variable "location" {
  description = "Storage account location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group to which storage account should belong to"
  type        = string
}

variable "account_tier" {
  description = "Standard/Premium"
  type        = string
}

variable "replication" {
  description = "Replication type of storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type        = string
}

variable "access_tier" {
  description = "Access tier of storage account. Hot/Cool"
  type        = string
}

variable "containers" {
  description = "Containers created in storage account. { container_name = access_tier }"
  type        = map(string)
  default     = {}
}

variable "queues" {
  description = "List of queues created in storage account"
  type        = set(string)
  default     = []
}

variable "tables" {
  description = "List of tables created in storage account"
  type        = set(string)
  default     = []
}

variable "blob_last_access_time" {
  description = "Enable last access time based tracking"
  type        = bool
  default     = false
}

variable "blob_versioning" {
  description = "Enable blob versioning. If enabled, configure data lifecycle to lower cost"
  type        = bool
  default     = false
}

variable "blob_delete_retention" {
  description = "Enable blob soft delete and set the retention in days"
  type        = number
  default     = 7
}

variable "container_delete_retention" {
  description = "Enable container soft delete and set the retention in days"
  type        = number
  default     = 7
}

variable "tags" {
  description = "List of default tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "cors_rules" {
  description = "CORS rules for storage account."
  type = list(object({
    allowed_origins    = list(string)
    allowed_methods    = list(string)
    allowed_headers    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  default = []
}
