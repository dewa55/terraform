variable "name" {
  description = "Name of the App service"
  type        = string
}

variable "location" {
  description = "App service location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group to which App service should belong to"
  type        = string
}

variable "app_service_plan_id" {
  description = "ID of the app service plan on which app service will be hosted"
  type        = string
}

variable "https_only" {
  description = "Disable HTTP access"
  default     = true
  type        = bool
}

variable "linux_fx_version" {
  description = "Runtime specification (language|version)"
  type        = string
}

variable "startup_command" {
  description = "Command to run on app startup. Set null if not used"
  type        = string
}

variable "app_settings" {
  description = "App Service app_settings"
  type        = map(string)
  default     = {}
}

variable "authorized_ips" {
  description = "IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction"
  type = list(
    object({
      name = string
      ip   = string
    })
  )
  default = []
}


variable "site_config" {
  description = "Site config for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#site_config. IP restriction attribute is no more managed in this block."
  type        = any
  default     = {}
}
