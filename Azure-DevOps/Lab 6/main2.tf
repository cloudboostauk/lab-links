data "azurerm_client_config" "current" {}
 
resource "azurerm_key_vault" "main" {
  name                = "kv-novapay-${random_integer.suffix.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
 
  # Let the identity running this Terraform manage secrets.
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    secret_permissions = ["Get", "List", "Set", "Delete", "Purge"]
  }
}
 
resource "azurerm_key_vault_secret" "environment" {
  name         = "environment-name"
  value        = "Production"
  key_vault_id = azurerm_key_vault.main.id
}
 
resource "azurerm_key_vault_secret" "support_email" {
  name         = "support-email"
  value        = "support@novapay.example.com"
  key_vault_id = azurerm_key_vault.main.id
}
