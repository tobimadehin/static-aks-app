resource "azurerm_container_registry" "default" {
  name                = "registry787898"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "Standard"
}