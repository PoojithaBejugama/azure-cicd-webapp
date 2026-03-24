# ============================================
# DEVELOPMENT ENVIRONMENT - PROVIDER CONFIGURATION
# ============================================
# Azure provider configuration for the dev environment

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Uncomment and set these if not using Azure CLI authentication
  # subscription_id = var.subscription_id
  # tenant_id       = var.tenant_id
}
