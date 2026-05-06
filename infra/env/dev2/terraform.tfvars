# ============================================
# DEVELOPMENT ENVIRONMENT - CONFIGURATION
# ============================================
# Variable values for the development environment

location          = "australiacentral"
environment_name  = "dev2"
resource_prefix   = "pooja"
app_service_sku   = "B1"
node_version      = "18-lts"
acr_name          = "myacrpoojademo"
acr_sku           = "Basic"
acr_admin_enabled = false
aks_node_count    = 1
aks_node_vm_size  = "Standard_D2s_v3"

common_tags = {
  ManagedBy   = "Terraform"
  Environment = "dev2"
  Project     = "K8-Demo"
}
