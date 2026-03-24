output "registry_name" {
  description = "Name of the container registry"
  value       = azurerm_container_registry.acr.name
}

output "login_server" {
  description = "Login server for the container registry"
  value       = azurerm_container_registry.acr.login_server
}

output "admin_username" {
  description = "Admin username for the registry"
  value       = azurerm_container_registry.acr.admin_username
  sensitive   = true
}

output "admin_password" {
  description = "Admin password for the registry"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}

output "registry_id" {
  description = "ID of the container registry"
  value       = azurerm_container_registry.acr.id
}