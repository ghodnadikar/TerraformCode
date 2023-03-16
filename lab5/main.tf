resource "azurerm_resource_group" "rg1" {
  count = 3
  name = "${var.rgname}${count.index+1}"
  location = var.rglocation
}
