resource "azurerm_resource_group" "andrei" {
  name     = "andrei-juneploy-test"
  location = "West Europe"
  tags = {
    owner = "andrei.inizian@redbull.com"
  }
}

resource "azurerm_virtual_network" "andrei-vnet" {
  name                = "andrei-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.andrei.location
  resource_group_name = azurerm_resource_group.andrei.name
}

resource "azurerm_subnet" "andrei_subnet" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.andrei.name
  virtual_network_name = azurerm_virtual_network.andrei-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}