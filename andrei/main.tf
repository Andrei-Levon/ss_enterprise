resource "azurerm_resource_group" "andrei" {
  name     = "andrei-juneploy-test"
  location = "West Europe"
  tags = {
    owner = "andrei.inizian@redbull.com"
  }
}