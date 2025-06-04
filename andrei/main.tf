resource "azurerm_resource_group" "andrei" {
  name     = "andrei-juneploy-test"
  location = "North Europe"
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
 
resource "azurerm_network_interface" "andrei-nic" {

  name                = "andrei-nic"

  location            = azurerm_resource_group.andrei.location

  resource_group_name = azurerm_resource_group.andrei.name
 
  ip_configuration {

    name                          = "example-ipcfg"

    subnet_id                     = azurerm_subnet.andrei_subnet.id

    private_ip_address_allocation = "Dynamic"

  }

}


resource "azurerm_linux_virtual_machine" "vm" {

  name                = "andrei-juneploy-vm"

  location            = azurerm_resource_group.andrei.location

  resource_group_name = azurerm_resource_group.andrei.name

  network_interface_ids = [

    azurerm_network_interface.andrei-nic.id,

  ]

  size               = "Standard_D2ds_v4"

  admin_username     = "andrei"

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