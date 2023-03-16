resource "azurerm_virtual_network" "vnet1" {

  name                = var.vnet_name
  location            = var.vnet_location
  resource_group_name = var.ResourceGroup_Name
  address_space       = [var.Vnet_addressspace]
  
}

resource "azurerm_subnet" "subnets" {
   name                 = var.subnetname
  resource_group_name  = var.ResourceGroup_Name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnetAddress]
  depends_on = [
    azurerm_virtual_network.vnet1
  ]
}