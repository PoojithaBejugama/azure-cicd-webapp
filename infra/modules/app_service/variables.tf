variable "plan_name" {
  description = "Name of the Azure App Service Plan"
  type        = string
}

variable "app_name" {
  description = "Name of the Azure Web App"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the App Service Plan (e.g., B1, B2, S1)"
  type        = string
  default     = "B1"
}

variable "node_version" {
  description = "Node.js version to use"
  type        = string
  default     = "18-lts"
}

variable "app_settings" {
  description = "Application settings for the Web App"
  type        = map(string)
  default     = {}
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
