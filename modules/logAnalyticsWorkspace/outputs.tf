output "workspace_key" {
  value = azurerm_log_analytics_workspace.law.primary_shared_key
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}

output "workspace_name" {
  value = azurerm_log_analytics_workspace.law.name
}