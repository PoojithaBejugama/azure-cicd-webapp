# ============================================
# DEVELOPMENT ENVIRONMENT - CONFIGURATION
# ============================================
# Variable values for the development environment

location          = "Canada Central"
environment_name  = "dev"
resource_prefix   = "pooja"
app_service_sku   = "B1"
node_version      = "18-lts"

common_tags = {
  ManagedBy   = "Terraform"
  Environment = "dev"
  Project     = "DevOps-Demo"
}
