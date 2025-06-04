resource "azurerm_resource_group" "claudiu" {
  name     = "claudiu-juneploy-test"
  location = "West Europe"
  tags = {
    owner = "claudiu.bandac@redbull.com"
  }
}