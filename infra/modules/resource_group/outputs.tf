output "resource_group_id" {
  description = "ID of the created Resource Group"
  value       = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  description = "Name of the created Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "Location of the Resource Group"
  value       = azurerm_resource_group.rg.location
}
