output "service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.plan.id
}

output "service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.plan.name
}

output "webapp_id" {
  description = "ID of the Web App"
  value       = azurerm_linux_web_app.webapp.id
}

output "webapp_name" {
  description = "Name of the Web App"
  value       = azurerm_linux_web_app.webapp.name
}

output "webapp_url" {
  description = "URL of the Web App"
  value       = azurerm_linux_web_app.webapp.default_hostname
}

output "webapp_principal_id" {
  description = "Principal ID of the Web App's managed identity"
  value       = try(azurerm_linux_web_app.webapp.identity[0].principal_id, null)
}
