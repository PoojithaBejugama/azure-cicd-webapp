# ============================================
# PRODUCTION ENVIRONMENT - ROOT CONFIGURATION
# ============================================

locals {
  env_short = "p"

  resource_group_name = "rg-${var.environment_name}-${var.resource_prefix}-demo"
  plan_name           = "asp-${var.environment_name}-${var.resource_prefix}-demo"
  app_name            = "webapp-${var.resource_prefix}-${var.environment_name}-demo"
  app_insights_name   = "appi-${var.environment_name}-${var.resource_prefix}-demo"

  common_tags = merge(
    var.common_tags,
    {
      Environment = var.environment_name
    }
  )
}

module "resource_group" {
  source = "../../modules/resource_group"

  resource_group_name = local.resource_group_name
  location            = var.location
  common_tags         = local.common_tags
}

module "application_insights" {
  source = "../../modules/application_insights"

  app_insights_name   = local.app_insights_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  common_tags         = local.common_tags
}

module "app_service" {
  source = "../../modules/app_service"

  plan_name           = local.plan_name
  app_name            = local.app_name
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  sku_name            = var.app_service_sku
  node_version        = var.node_version

 

  depends_on = [module.resource_group]
}
