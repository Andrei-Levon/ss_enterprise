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


# Define the network interface

resource "azurerm_network_interface" "claudiu-nic" {
  name                = "claudiu-nic"
  location            = azurerm_resource_group.claudiu.location
  resource_group_name = azurerm_resource_group.claudiu.name

  ip_configuration {
    name                          = "example-ipcfg"
    subnet_id                     = azurerm_subnet.claudiu.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "claudiu-juneploy-vm"
  location            = azurerm_resource_group.claudiu.location
  resource_group_name = azurerm_resource_group.claudiu.name
  network_interface_ids = [
    azurerm_network_interface.claudiu-nic.id,
  ]
  size               = "Standard_D2ds_v4"
  admin_username     = "claudiu"
  admin_password     = "34FDA$#214f"  # For demonstration purposes only. Use secure methods for production.
  disable_password_authentication = "false"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
