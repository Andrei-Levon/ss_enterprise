resource "azurerm_resource_group" "vlad" {
  name     = "vlad-juneploy-test"
  location = "West Europe"
  tags = {
    owner = "vlad.orascu@redbull.com"
  }
}

resource "azurerm_virtual_network" "vlad-wmnet" {
  name                = "vlad-wmnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vlad.location
  resource_group_name = azurerm_resource_group.vlad.name
}

resource "azurerm_subnet" "vlad_subnet" {
  name                 = "vlad-subnet"
  resource_group_name  = azurerm_resource_group.vlad.name
  virtual_network_name = azurerm_virtual_network.vlad-wmnet.name
  address_prefixes     = ["10.0.1.0/24"]
  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}