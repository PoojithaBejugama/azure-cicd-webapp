# ============================================
# APP SERVICE MODULE
# ============================================

resource "azurerm_service_plan" "plan" {
  name                = var.plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name

  tags = merge(
    var.common_tags,
    { Name = var.plan_name }
  )
}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = var.app_settings

  tags = merge(
    var.common_tags,
    { Name = var.app_name }
  )
}
