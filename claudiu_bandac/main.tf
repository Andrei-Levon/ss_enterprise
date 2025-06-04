resource "azurerm_resource_group" "claudiu" {
  name     = "claudiu-juneploy-test"
  location = "West Europe"
  tags = {
    owner = "claudiu.bandac@redbull.com"
  }
}

resource "azurerm_virtual_network" "claudiu" {
  name                = "claudiu-juneploy-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.claudiu.location
  resource_group_name = azurerm_resource_group.claudiu.name
}

resource "azurerm_subnet" "claudiu" {
  name                 = "claudiu-subnet"
  resource_group_name  = azurerm_resource_group.claudiu.name
  virtual_network_name = azurerm_virtual_network.claudiu.name
  address_prefixes     = ["10.0.10.0/24"]
}
