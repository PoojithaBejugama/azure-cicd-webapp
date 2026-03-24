# ============================================
# STAGING ENVIRONMENT - CONFIGURATION
# ============================================

location          = "Canada Central"
environment_name  = "staging"
resource_prefix   = "pooja"
app_service_sku   = "B2"
node_version      = "18-lts"

common_tags = {
  ManagedBy   = "Terraform"
  Environment = "staging"
  Project     = "DevOps-Demo"
}
