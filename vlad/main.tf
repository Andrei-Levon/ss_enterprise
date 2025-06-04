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
  }

  resource "azurerm_network_interface" "vlad-nic" {
  name                = "vlad-nic"
  location            = azurerm_resource_group.vlad.location
  resource_group_name = azurerm_resource_group.vlad.name

  ip_configuration {
    name                          = "vlad-ipcfg"
    subnet_id                     = azurerm_subnet.vlad_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vlad-vm"
  location            = azurerm_resource_group.vlad.location
  resource_group_name = azurerm_resource_group.vlad.name
  network_interface_ids = [
    azurerm_network_interface.vlad-nic.id,
  ]
  size               = "Standard_DS1_v2"
  admin_username     = "vlad"
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