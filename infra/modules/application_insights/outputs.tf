output "app_insights_id" {
  description = "ID of the Application Insights instance"
  value       = azurerm_application_insights.ai.id
}

output "app_insights_name" {
  description = "Name of the Application Insights instance"
  value       = azurerm_application_insights.ai.name
}

output "connection_string" {
  description = "Connection string for Application Insights"
  value       = azurerm_application_insights.ai.connection_string
  sensitive   = true
}

output "instrumentation_key" {
  description = "Instrumentation key for Application Insights"
  value       = azurerm_application_insights.ai.instrumentation_key
  sensitive   = true
}
