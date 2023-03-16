resource "azurerm_resource_group" "rg1" {
  count = length(var.rgname)
  name = var.rgname[count.index]
  location = var.rglocation
}



