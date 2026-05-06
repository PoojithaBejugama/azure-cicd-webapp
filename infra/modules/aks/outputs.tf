output "cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "cluster_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "kube_config" {
  description = "Raw kubeconfig for the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "kubelet_object_id" {
  description = "Object ID of the AKS kubelet identity used for ACR pull permissions"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "fqdn" {
  description = "AKS cluster API server FQDN"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}
