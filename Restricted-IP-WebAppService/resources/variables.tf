variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "main_rg_name" {
  type = string
}

variable "main_keyvault_name" {
  type = string
}
variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_cidr" {
  type = list(string)
}

variable "cicd_principal_id" {
  type = string
}

variable "appservice_plan" {
  type = string
}

variable "appservice_plan_sku_tier" {
  type = string
}

variable "appservice_plan_sku_size" {
  type = string
}

variable "web_api_name" {
  type = string
}
variable "web_api_ApiUrl" {
  type = string
}
variable "web_api_ApiUrlTest" {
  type = string
}

variable "web_ui_name" {
  type = string
}

variable "actiongroup_name" {
  type = string
}

variable "actiongroup_shortname" {
  type = string
  validation {
    condition     = length(var.actiongroup_shortname) < 13
    error_message = "The action group shortname cannot be longer then 12 characters."
  }
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
