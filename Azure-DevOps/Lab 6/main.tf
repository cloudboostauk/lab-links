resource "azurerm_resource_group" "main" {
  name     = "rg-novapay-capstone"
  location = "westeurope"
}
 
resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}
 
resource "azurerm_storage_account" "main" {
  name                     = "stnovapaycap${random_integer.suffix.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
 
  static_website {
    index_document = "index.html"
  }
}