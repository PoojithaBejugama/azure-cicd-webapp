# ============================================
# PRODUCTION ENVIRONMENT - CONFIGURATION
# ============================================

location          = "Canada Central"
environment_name  = "prod"
resource_prefix   = "pooja"
app_service_sku   = "S1"
node_version      = "18-lts"

common_tags = {
  ManagedBy   = "Terraform"
  Environment = "prod"
  Project     = "DevOps-Demo"
}
