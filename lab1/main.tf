provider "azurerm" {
  features {

  }
}

# Create a resource group
resource "azurerm_resource_group" "blockname1" {
  name     = "dc5000"
  location = "west us3"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "ibm-vnet"
  location            = azurerm_resource_group.blockname1.location
  resource_group_name = azurerm_resource_group.blockname1.name
  address_space       = ["172.26.1.0/24", "172.26.2.0/24", "172.26.3.0/24"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  depends_on = [
    azurerm_resource_group.blockname1
  ]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.blockname1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["172.26.1.0/24"]
  depends_on = [
    azurerm_resource_group.blockname1, azurerm_virtual_network.vnet1
  ]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "app-subnet"
  resource_group_name  = azurerm_resource_group.blockname1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["172.26.2.0/24"]
  depends_on = [
    azurerm_resource_group.blockname1, azurerm_virtual_network.vnet1
  ]
}

resource "azurerm_network_interface" "nic1" {
  name                = "appserver-nic"
  location            = azurerm_resource_group.blockname1.location
  resource_group_name = azurerm_resource_group.blockname1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "nic2" {
  name                = "web-nic"
  location            = azurerm_resource_group.blockname1.location
  resource_group_name = azurerm_resource_group.blockname1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}