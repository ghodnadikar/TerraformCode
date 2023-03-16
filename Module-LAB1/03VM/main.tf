
############### This is IMP Code ##############
data "azurerm_virtual_network" "vnet1" {
  name                = var.vnet_name
  resource_group_name = var.rg
}
data "azurerm_subnet" "subnets" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet1.name
  resource_group_name  = data.azurerm_virtual_network.vnet1.resource_group_name

}

############### This is IMP Code ##############

resource "azurerm_network_interface" "main" {

  name                = "${var.VMname}-nic"
  location            = var.rglocation
  resource_group_name = var.rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnets.*.id[0] ## This line is IMP to understand 
    private_ip_address_allocation = "Dynamic"

  }
}

resource "azurerm_windows_virtual_machine" "example" {

  name                  = var.VMname
  resource_group_name   = var.rg
  location              = var.rglocation
  size                  = var.vm_size
  admin_username        = var.username
  admin_password        = var.passcode
  network_interface_ids = [azurerm_network_interface.main.id]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.version_type
  }
  depends_on = [
    azurerm_network_interface.main
  ]
}