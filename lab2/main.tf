provider "azurerm" {
  features {

  }
}

# Create a resource group
resource "azurerm_resource_group" "blockname1" {
  name     = var.rgname
  location = var.rglocation
}


resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnetname
  location            = azurerm_resource_group.blockname1.location
  resource_group_name = azurerm_resource_group.blockname1.name
  address_space       = [var.addressspace1]
  dns_servers         = [var.dnsserver1]
  depends_on = [
    azurerm_resource_group.blockname1
  ]
}




resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet11
  resource_group_name  = azurerm_resource_group.blockname1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.addressprefix11]
  depends_on = [
    azurerm_resource_group.blockname1, azurerm_virtual_network.vnet1
  ]
}

resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet12
  resource_group_name  = azurerm_resource_group.blockname1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.addressprefix12]
  depends_on = [
    azurerm_resource_group.blockname1, azurerm_virtual_network.vnet1
  ]
}

resource "azurerm_network_interface" "nic1" {
  name                = var.nicname1
  location            = azurerm_resource_group.blockname1.location
  resource_group_name = azurerm_resource_group.blockname1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = var.ip_address_allocation
  }
}

resource "azurerm_network_interface" "nic2" {
  name                = var.nicname2
  location            = azurerm_resource_group.blockname1.location
  resource_group_name = azurerm_resource_group.blockname1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = var.ip_address_allocation
  }
}





