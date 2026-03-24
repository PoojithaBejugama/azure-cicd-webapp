# ============================================
# DEVELOPMENT ENVIRONMENT - INPUT VARIABLES
# ============================================

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = ""
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = ""
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}

variable "environment_name" {
  description = "Name of the environment (e.g., dev, staging, prod)"
  type        = string
}

variable "resource_prefix" {
  description = "Prefix for resource names (e.g., 'pooja')"
  type        = string
}

variable "app_service_sku" {
  description = "SKU tier for App Service Plan"
  type        = string
  default     = "B1"
}

variable "node_version" {
  description = "Node.js version for web app"
  type        = string
  default     = "18-lts"
}

variable "common_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}
