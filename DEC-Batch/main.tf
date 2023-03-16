provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "rg1" {
  name = "DC900"
  location = "west us3"
}



resource "azurerm_virtual_network" "vnet1" {
  name                = "my-vnet-infra"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["192.168.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}


resource "azurerm_subnet" "subnet1" {
  name                 = "web-subnet"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["192.168.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "appserver-nic"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = "appserver"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = "Standard_B2s"
  admin_username      = "admin100"
  admin_password      = "Passw0rd@12345"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}