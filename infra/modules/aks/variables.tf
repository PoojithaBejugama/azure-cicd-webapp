variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where AKS will be created"
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster. Null lets Azure choose the default supported version."
  type        = string
  default     = null
}

variable "default_node_pool_name" {
  description = "Name of the default AKS node pool"
  type        = string
  default     = "system"
}

variable "node_count" {
  description = "Number of nodes when autoscaling is disabled"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "Virtual machine size for AKS nodes"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "enable_auto_scaling" {
  description = "Enable autoscaling for the default node pool"
  type        = bool
  default     = false
}

variable "min_node_count" {
  description = "Minimum node count when autoscaling is enabled"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum node count when autoscaling is enabled"
  type        = number
  default     = 3
}

variable "common_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default     = {}
}
