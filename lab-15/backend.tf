terraform {
  backend "azurerm" {
    resource_group_name  = "AK8_NEW"
    storage_account_name = "cloudtechnopune30"
    container_name       = "terraformstate"
    key                  = "infra.tfstate"
  }
}