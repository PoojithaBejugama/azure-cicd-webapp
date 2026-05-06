output "resource_group_name" {
  description = "Name of the deployed Resource Group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "ID of the deployed Resource Group"
  value       = module.resource_group.resource_group_id
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

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "aks_cluster_id" {
  description = "ID of the AKS cluster"
  value       = module.aks.cluster_id
}

output "aks_api_fqdn" {
  description = "AKS API server FQDN"
  value       = module.aks.fqdn
}

output "aks_get_credentials_command" {
  description = "Command to connect kubectl to this AKS cluster"
  value       = "az aks get-credentials --resource-group ${module.resource_group.resource_group_name} --name ${module.aks.cluster_name} --overwrite-existing"
}
