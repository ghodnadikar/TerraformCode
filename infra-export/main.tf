resource "azurerm_resource_group" "res-0" {
  location = "westus3"
  name     = "AK8_NEW"
}
resource "azurerm_windows_virtual_machine" "res-1" {
  admin_password        = "ignored-as-imported"
  admin_username        = "admin100"
  location              = "westus3"
  name                  = "Terraform"
  network_interface_ids = ["/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/networkInterfaces/terraform34"]
  resource_group_name   = "AK8_NEW"
  size                  = "Standard_B2s"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2016-datacenter-gensecond"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-10,
  ]
}
resource "azurerm_windows_virtual_machine" "res-2" {
  admin_password        = "ignored-as-imported"
  admin_username        = "admin100"
  location              = "westus3"
  name                  = "Terraform-1"
  network_interface_ids = ["/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/networkInterfaces/terraform-1472"]
  resource_group_name   = "AK8_NEW"
  size                  = "Standard_B2s"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2016-datacenter-gensecond"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-8,
  ]
}
resource "azurerm_virtual_machine_extension" "res-3" {
  auto_upgrade_minor_version = true
  name                       = "MicrosoftMonitoringAgent"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  settings                   = "{\"workspaceId\":\"df169f02-2140-48db-9617-a626fbf71281\"}"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Compute/virtualMachines/Terraform-1"
  depends_on = [
    azurerm_windows_virtual_machine.res-2,
  ]
}
resource "azurerm_virtual_machine_extension" "res-4" {
  auto_upgrade_minor_version = true
  name                       = "MicrosoftMonitoringAgent"
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  settings                   = "{\"workspaceId\":\"df169f02-2140-48db-9617-a626fbf71281\"}"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Compute/virtualMachines/Terraform"
  depends_on = [
    azurerm_windows_virtual_machine.res-1,
  ]
}
resource "azurerm_virtual_machine_extension" "res-5" {
  auto_upgrade_minor_version = true
  name                       = "enablevmaccess"
  publisher                  = "Microsoft.Compute"
  settings                   = "{\"UserName\":\"admin200\"}"
  type                       = "VMAccessAgent"
  type_handler_version       = "2.0"
  virtual_machine_id         = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Compute/virtualMachines/Terraform"
  depends_on = [
    azurerm_windows_virtual_machine.res-1,
  ]
}
resource "azurerm_dev_test_global_vm_shutdown_schedule" "res-6" {
  daily_recurrence_time = "1900"
  location              = "westus3"
  timezone              = "UTC"
  virtual_machine_id    = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Compute/virtualMachines/Terraform"
  notification_settings {
    email   = "cloudtechnopune@outlook.com"
    enabled = true
  }
  depends_on = [
    azurerm_windows_virtual_machine.res-1,
  ]
}
resource "azurerm_dev_test_global_vm_shutdown_schedule" "res-7" {
  daily_recurrence_time = "1900"
  location              = "westus3"
  timezone              = "UTC"
  virtual_machine_id    = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Compute/virtualMachines/Terraform-1"
  notification_settings {
    email   = "yp@cloudtechnopuneoutlook.onmicrosoft.com"
    enabled = true
  }
  depends_on = [
    azurerm_windows_virtual_machine.res-2,
  ]
}
resource "azurerm_network_interface" "res-8" {
  location            = "westus3"
  name                = "terraform-1472"
  resource_group_name = "AK8_NEW"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/publicIPAddresses/Terraform-1-ip"
    subnet_id                     = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/virtualNetworks/AK8-New-VNET/subnets/Servers"
  }
  depends_on = [
    azurerm_public_ip.res-22,
    azurerm_subnet.res-26,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-9" {
  network_interface_id      = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/networkInterfaces/terraform-1472"
  network_security_group_id = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/networkSecurityGroups/Terraform-1-nsg"
  depends_on = [
    azurerm_network_interface.res-8,
    azurerm_network_security_group.res-16,
  ]
}
resource "azurerm_network_interface" "res-10" {
  location            = "westus3"
  name                = "terraform34"
  resource_group_name = "AK8_NEW"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/publicIPAddresses/Terraform-ip"
    subnet_id                     = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/virtualNetworks/AK8-New-VNET/subnets/Servers"
  }
  depends_on = [
    azurerm_public_ip.res-23,
    azurerm_subnet.res-26,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-11" {
  network_interface_id      = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/networkInterfaces/terraform34"
  network_security_group_id = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/networkSecurityGroups/Terraform-nsg"
  depends_on = [
    azurerm_network_interface.res-10,
    azurerm_network_security_group.res-18,
  ]
}
resource "azurerm_network_security_group" "res-12" {
  location            = "westus3"
  name                = "AD-nsg"
  resource_group_name = "AK8_NEW"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_security_rule" "res-13" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "AD-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "AK8_NEW"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-12,
  ]
}
resource "azurerm_network_security_group" "res-14" {
  location            = "westus3"
  name                = "Manojvm-nsg"
  resource_group_name = "AK8_NEW"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_security_rule" "res-15" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "Manojvm-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "AK8_NEW"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-14,
  ]
}
resource "azurerm_network_security_group" "res-16" {
  location            = "westus3"
  name                = "Terraform-1-nsg"
  resource_group_name = "AK8_NEW"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_security_rule" "res-17" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "Terraform-1-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "AK8_NEW"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-16,
  ]
}
resource "azurerm_network_security_group" "res-18" {
  location            = "westus3"
  name                = "Terraform-nsg"
  resource_group_name = "AK8_NEW"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_security_rule" "res-19" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "Terraform-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "AK8_NEW"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-18,
  ]
}
resource "azurerm_private_dns_zone" "res-20" {
  name                = "privatelink.database.windows.net"
  resource_group_name = "AK8_NEW"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-21" {
  name                  = "ecoe7jbwearmi"
  private_dns_zone_name = "privatelink.database.windows.net"
  resource_group_name   = "AK8_NEW"
  virtual_network_id    = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8_NEW/providers/Microsoft.Network/virtualNetworks/AK8-New-VNET"
  depends_on = [
    azurerm_private_dns_zone.res-20,
    azurerm_virtual_network.res-24,
  ]
}
resource "azurerm_public_ip" "res-22" {
  allocation_method   = "Static"
  location            = "westus3"
  name                = "Terraform-1-ip"
  resource_group_name = "AK8_NEW"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_public_ip" "res-23" {
  allocation_method   = "Static"
  location            = "westus3"
  name                = "Terraform-ip"
  resource_group_name = "AK8_NEW"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_virtual_network" "res-24" {
  address_space       = ["172.21.0.0/16"]
  location            = "westus3"
  name                = "AK8-New-VNET"
  resource_group_name = "AK8_NEW"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_subnet" "res-25" {
  address_prefixes     = ["172.21.1.0/24"]
  name                 = "AzureBastionSubnet"
  resource_group_name  = "AK8_NEW"
  virtual_network_name = "AK8-New-VNET"
  depends_on = [
    azurerm_virtual_network.res-24,
  ]
}
resource "azurerm_subnet" "res-26" {
  address_prefixes     = ["172.21.2.0/24"]
  name                 = "Servers"
  resource_group_name  = "AK8_NEW"
  virtual_network_name = "AK8-New-VNET"
  depends_on = [
    azurerm_virtual_network.res-24,
  ]
}
resource "azurerm_virtual_network_peering" "res-27" {
  name                      = "ak8-fe"
  remote_virtual_network_id = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/DC700/providers/Microsoft.Network/virtualNetworks/FE-VNET"
  resource_group_name       = "AK8_NEW"
  virtual_network_name      = "AK8-New-VNET"
  depends_on = [
    azurerm_virtual_network.res-24,
  ]
}
resource "azurerm_virtual_network_peering" "res-28" {
  name                      = "new-old"
  remote_virtual_network_id = "/subscriptions/687576b5-cfc7-4d84-a216-afe39d6e983e/resourceGroups/AK8/providers/Microsoft.Network/virtualNetworks/AK8-VNET"
  resource_group_name       = "AK8_NEW"
  virtual_network_name      = "AK8-New-VNET"
  depends_on = [
    azurerm_virtual_network.res-24,
  ]
}
resource "azurerm_storage_account" "res-29" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = "westus3"
  name                     = "cloudtechnopune30"
  resource_group_name      = "AK8_NEW"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_container" "res-31" {
  name                 = "script"
  storage_account_name = "cloudtechnopune30"
}
resource "azurerm_storage_container" "res-32" {
  name                 = "terraformstate"
  storage_account_name = "cloudtechnopune30"
}
