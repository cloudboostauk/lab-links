output "website_url" {
  value = azurerm_storage_account.main.primary_web_endpoint
}
output "storage_account_name" {
  value = azurerm_storage_account.main.name
}
output "key_vault_name" {
  value = azurerm_key_vault.main.name
}
