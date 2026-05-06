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

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "myacrpoojademo"
}

variable "acr_sku" {
  description = "SKU for Azure Container Registry"
  type        = string
  default     = "Basic"
}

variable "acr_admin_enabled" {
  description = "Enable ACR admin user. Keep false for AKS because AKS uses AcrPull role assignment."
  type        = bool
  default     = false
}

variable "aks_node_count" {
  description = "Number of AKS nodes when autoscaling is disabled"
  type        = number
  default     = 2
}

variable "aks_node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "aks_enable_auto_scaling" {
  description = "Enable autoscaling for the AKS default node pool"
  type        = bool
  default     = false
}

variable "aks_min_node_count" {
  description = "Minimum AKS node count when autoscaling is enabled"
  type        = number
  default     = 1
}

variable "aks_max_node_count" {
  description = "Maximum AKS node count when autoscaling is enabled"
  type        = number
  default     = 3
}

variable "common_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}
