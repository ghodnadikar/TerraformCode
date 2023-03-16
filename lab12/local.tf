## fe-vnet
locals  {
  vnets = {
    vnet1 = {name = var.vnetname1 , vnet-location = var.vnetlocation , resourcegroupname = var.vnetrgname , address_space = var.addressspace1},
    
  }
}

locals {
  subnetes = {
    #AzureFirewallSubnet
    subnet1 = {subnetname = var.subnet11 , resourcegroupname = var.vnetrgname , virtualnetworkname = var.vnetname1 , addressprefix = var.addressprefix11},
    #mgmt Subnet
    subnet2 = {subnetname = var.subnet12 , resourcegroupname = var.vnetrgname , virtualnetworkname = var.vnetname1 , addressprefix = var.addressprefix12}
    
    # Application Subnet
    subnet3 = {subnetname = var.subnet13 , resourcegroupname = var.vnetrgname , virtualnetworkname = var.vnetname1 , addressprefix = var.addressprefix13}
  
  # DB Subnet
    subnet4 = {subnetname = var.subnet14 , resourcegroupname = var.vnetrgname , virtualnetworkname = var.vnetname1 , addressprefix = var.addressprefix14}
  # QA Subnet
    subnet5 = {subnetname = var.subnet15 , resourcegroupname = var.vnetrgname , virtualnetworkname = var.vnetname1 , addressprefix = var.addressprefix15}

  }
}


locals {
  Nic_Vm={
    NIC_1={resource_group_name = var.rgname, location = var.rglocation, subnet_id = var.subnet12, VMname = "server100", size = var.vm_size}
    #NIC_2={resource_group_name = var.rg101, location = var.rglocation, subnet_id = var.appsubnet, name = "${var.prefix}-vm2", size = var.vm_size}
    #NIC_3={resource_group_name = var.rg101, location = var.rglocation, subnet_id = var.dbsubnet, name = "${var.prefix}-vm3", size = var.vm_size}
  }
 }


