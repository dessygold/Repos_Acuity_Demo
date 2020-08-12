output "workspace_key" {
  value = azurerm_log_analytics_workspace.laws.primary_shared_key
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.laws.id
}

output "workspace_name" {
  value = azurerm_log_analytics_workspace.laws.name
}