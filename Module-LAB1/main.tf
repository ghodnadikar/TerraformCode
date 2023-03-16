###### RG-Module#####

module "RG" {
  source     = "./01RG"
  rgname     = "MYDC24000"
  rglocation = "east us"
}


########## VNET-Module ######
module "VNET" {
  source = "./02VNET"

  vnet_name = "data-vnet"

  vnet_location     = "east us"
  Vnet_addressspace = "192.168.0.0/16"

  ResourceGroup_Name = "MYDC24000"
  subnetname         = "websubnet"

  subnetAddress = "192.168.1.0/24"
  depends_on = [
    module.RG
  ]

}

############################VM-Module #########################
module "VM" {
  source = "./03VM"
  VMname = "APPServer"
rg = "MYDC24000"
rglocation = "east us"
vm_size = "Standard_B1s"
username = "admin100"
passcode = "Passw0rd@12345"
caching = "ReadWrite"
storage_account_type = "Standard_LRS"
publisher = "MicrosoftWindowsServer"
offer = "WindowsServer"
sku = "2016-Datacenter"
version_type = "latest"
vnet_name = "data-vnet"
subnet_name = "websubnet"
depends_on = [
  module.RG , module.VNET
]
}
