  rgname = "DC9000"
  rglocation           = "west us3"

vnetname1       = "fe-vnet"
  vnetlocation    = "west us3"
  vnetrgname = "DC9000"
 subnet11        = "AzureFirewallSubnet"
  subnet12        = "mgmt" 
  subnet13        = "appsubnet"
  subnet14        = "dbsubnet"
  subnet15 = "QA"
  addressspace1   = ["172.29.0.0/16"]
  addressprefix11 = ["172.29.1.0/24"]
  addressprefix12 = ["172.29.2.0/24"]
  addressprefix13 = ["172.29.3.0/24"]
  addressprefix14 = ["172.29.4.0/24"]
  addressprefix15 = ["172.29.5.0/24"]
  vm_size =  "Standard_B1s"
   username             = "admin100"
 passcode             = "Passw0rd@12345"
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  publisher            = "MicrosoftWindowsServer"
  offer                = "WindowsServer"
  sku                  = "2016-Datacenter"
  version_type         = "latest"


