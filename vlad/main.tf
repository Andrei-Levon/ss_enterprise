resource "azurerm_resource_group" "vlad" {
  name     = "vlad-juneploy-test"
  location = "West Europe"
  tags = {
    owner = "vlad.orascu@redbull.com"
  }
}