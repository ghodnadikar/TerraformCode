provider "azurerm" {
  features {}
}
################### MAP ######
resource "azurerm_resource_group" "rg" {
  for_each = var.rgname
    name     = each.value["name"]
  location = each.value["location"]
}