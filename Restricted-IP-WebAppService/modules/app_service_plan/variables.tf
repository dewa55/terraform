variable "name" {
  description = "Name of the App service plan"
  type        = string
}

variable "location" {
  description = "App service plan location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group to which App service plan should belong to"
  type        = string
}

variable "sku_tier" {
  default = "Standard"
  type    = string
}

variable "sku_size" {
  default = "S1"
  type    = string
}

variable "os_type" {
  description = "Type of OS on app service plan"
  default     = "Linux"
  type        = string
}