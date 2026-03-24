# ============================================
# DEVELOPMENT ENVIRONMENT - OUTPUTS
# ============================================

output "resource_group_name" {
  description = "Name of the deployed Resource Group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "ID of the deployed Resource Group"
  value       = module.resource_group.resource_group_id
}

output "webapp_url" {
  description = "URL to access the deployed web application"
  value       = "https://${module.app_service.webapp_url}"
}

output "app_service_plan_id" {
  description = "ID of the App Service Plan"
  value       = module.app_service.service_plan_id
}

output "application_insights_name" {
  description = "Name of Application Insights instance"
  value       = module.application_insights.app_insights_name
}

output "acr_login_server" {
  description = "Login server for the Azure Container Registry"
  value       = module.container_registry.login_server
}

output "acr_admin_username" {
  description = "Admin username for ACR"
  value       = module.container_registry.admin_username
  sensitive   = true
}

output "acr_admin_password" {
  description = "Admin password for ACR"
  value       = module.container_registry.admin_password
  sensitive   = true
}
