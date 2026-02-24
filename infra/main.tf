# Tell Terraform we are using Azure
provider "azurerm" {
  features {}
}

# ---------------------------
# RESOURCE GROUP
# ---------------------------
resource "azurerm_resource_group" "rg" {
  name     = "rg-devops-newProject-demo"
  location = "Canada Central"
}

# ---------------------------
# APP SERVICE PLAN
# ---------------------------
# This defines the compute tier for the web app
resource "azurerm_service_plan" "plan" {
  name                = "asp-devops-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  os_type  = "Linux"
  sku_name = "B1"  # Cheap tier
}

# ---------------------------
# APPLICATION INSIGHTS
# ---------------------------
resource "azurerm_application_insights" "ai" {
  name                = "appi-devops-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

# ---------------------------
# WEB APP (Node)
# ---------------------------
resource "azurerm_linux_web_app" "webapp" {
  name                = "webapp-pooja-devops-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }

  # Connect App Insights automatically
  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.ai.connection_string
  }
}

# Random suffix to avoid global name conflict
resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# ---------------------------
# OUTPUTS
# ---------------------------
output "webapp_url" {
  value = azurerm_linux_web_app.webapp.default_hostname
}

output "webapp_name" {
  value = azurerm_linux_web_app.webapp.name
}

output "rg_name" {
  value = azurerm_resource_group.rg.name
}
