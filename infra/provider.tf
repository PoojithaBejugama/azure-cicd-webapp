# Tell Terraform we are using Azure
provider "azurerm" {
  features {}

   #subscription_id = var.subscription_id  # Optional
  # tenant_id     = var.tenant_id        # Optional

}