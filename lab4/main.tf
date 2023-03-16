

resource "azurerm_resource_group" "rg1" {
  name = var.rgname
  location = var.rglocation
}


resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnetname
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = [var.addressspace1]
  dns_servers         = [var.dnsserver1]
  depends_on = [
    azurerm_resource_group.rg1
  ]
}


resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet11
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [var.addressprefix11]
  depends_on = [
    azurerm_resource_group.rg1 , azurerm_virtual_network.vnet1
  ]
}


resource "azurerm_public_ip" "pip" {
  name                = "appserver-pip"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = var.nicname
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  depends_on = [
    azurerm_subnet.subnet1
  ]
}

########## This is for NSG for VM ##################
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsgname
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  security_rule {
    name                       = "rule1-rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
      }
      
      depends_on = [
        azurerm_resource_group.rg1
      ]
}

resource "azurerm_network_interface_security_group_association" "association1" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [
    azurerm_network_interface.nic , azurerm_network_security_group.nsg
  ]
}

######### This is for  for VM ##################

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vmname
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = var.vmsize  # "Standard_B2s"
  admin_username      = var.username
  admin_password      = var.password
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

