######### This is for  for VM ##################

resource "azurerm_windows_virtual_machine" "vm" {
 count = var.machinecount
  name                =    "${var.vmname}${count.index+1}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = var.vmsize  # "Standard_B2s"
  admin_username      = var.username
  admin_password      = var.password
  network_interface_ids = [
     azurerm_network_interface.nic[count.index].id,]
  

   

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

