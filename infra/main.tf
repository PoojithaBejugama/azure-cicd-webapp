

# ---------------------------
# RESOURCE GROUP
# ---------------------------
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# ---------------------------
# APP SERVICE PLAN
# ---------------------------
# This defines the compute tier for the web app
module "app_service" {
  source = "./modules/app_service"

  plan_name = "asp-${var.environment}-demo"
  app_name            = "webapp-pooja-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "B1"
  node_version        = "18-lts"
  
}

# ---------------------------
# APPLICATION INSIGHTS
# ---------------------------
resource "azurerm_application_insights" "ai" {
  name                = "appi-devops-demo"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

# ---------------------------
# WEB APP (Node)
# ---------------------------
resource "azurerm_linux_web_app" "webapp" {
  name                = "webapp-pooja-devops-demo"
  location            = var.location
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
