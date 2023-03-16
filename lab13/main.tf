provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg1" {
  name = var.rgname
  location = var.rglocation
}

resource "azurerm_virtual_network" "vnet1" {
  for_each = local.vnets
  name                = each.value.name
  location            =  each.value.vnet-location
  resource_group_name = each.value.resourcegroupname
  address_space       = each.value.address_space
}

resource "azurerm_subnet" "subnets" {
  for_each = local.subnetes
  name                 = each.value.subnetname
  resource_group_name  = each.value.resourcegroupname
  virtual_network_name = each.value.virtualnetworkname
  address_prefixes     = each.value.addressprefix
  depends_on = [
    azurerm_virtual_network.vnet1
  ]
}





# resource "azurerm_network_interface" "main" {
#   for_each            = local.Nic_Vm
#   name                = each.key
#   location            = each.value.location
#   resource_group_name = each.value.resource_group_name

#   ip_configuration {
#     name                          = "testconfiguration1"
#     subnet_id                     = each.value.subnet_id
#     private_ip_address_allocation = "Dynamic"
#     # public_ip_address_id = azurerm_public_ip.publicip1.id
#   }
# }


# resource "azurerm_windows_virtual_machine" "example" {
#   for_each            = local.Nic_Vm
#   name                = each.value.VMname
#   resource_group_name = each.value.resource_group_name
#   location            = each.value.location
#   size                = each.value.size
#   admin_username      = var.username
#   admin_password      = var.passcode
#   #network_interface_ids = [each.value.network_interface_ids]
#   network_interface_ids = [azurerm_network_interface.main[each.key].id,]

#   os_disk {
#     caching              = var.caching
#     storage_account_type = var.storage_account_type
#   }
#   source_image_reference {
#     publisher = var.publisher
#     offer     = var.offer
#     sku       = var.sku
#     version   = var.version_type
#   }
# }