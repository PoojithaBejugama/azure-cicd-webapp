//dev2 - for AKS and ACR deployment

locals {
  env_short = "d2"

  resource_group_name = "rg-${var.environment_name}-${var.resource_prefix}-demo"
  plan_name           = "asp-${var.environment_name}-${var.resource_prefix}-demo"
  app_name            = "webapp-${var.resource_prefix}-${var.environment_name}-demo"
  app_insights_name   = "appi-${var.environment_name}-${var.resource_prefix}-demo"
  aks_cluster_name    = "aks-${var.resource_prefix}-${var.environment_name}-demo"
  aks_dns_prefix      = "aks-${var.resource_prefix}-${var.environment_name}"

  common_tags = merge(
    var.common_tags,
    {
      Environment = var.environment_name
    }
  )
}

# ============================================
# RESOURCE GROUP MODULE
# ============================================
module "resource_group" {
  source = "../../modules/resource_group"

  resource_group_name = local.resource_group_name
  location            = var.location
  common_tags         = local.common_tags
}

# ============================================
# CONTAINER REGISTRY MODULE
# ============================================
module "container_registry" {
  source = "../../modules/container_registry"

  registry_name       = var.acr_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled

  common_tags = local.common_tags

  # Explicit dependency to ensure RG is created first
  depends_on = [module.resource_group]
}
# ============================================
# AKS MODULE
# ============================================
module "aks" {
  source = "../../modules/aks"

  cluster_name        = local.aks_cluster_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  dns_prefix          = local.aks_dns_prefix

  node_count          = var.aks_node_count
  node_vm_size        = var.aks_node_vm_size
  enable_auto_scaling = var.aks_enable_auto_scaling
  min_node_count      = var.aks_min_node_count
  max_node_count      = var.aks_max_node_count

  common_tags = local.common_tags

  depends_on = [module.resource_group]
}

# Allow AKS nodes to pull images from ACR without using ACR admin credentials.
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = module.container_registry.registry_id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_object_id

  depends_on = [
    module.aks,
    module.container_registry
  ]
}
