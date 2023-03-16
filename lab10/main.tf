provider "azurerm" {
  features {}
}




resource "azurerm_resource_group" "rg" {
  for_each = toset(var.rgname)
  name = each.value
    location = var.location
}