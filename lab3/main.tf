resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.rglocation
}



resource "azurerm_kubernetes_cluster" "aks11" {
  name                = "${var.prefix}-cluster1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-dns"

  default_node_pool {
    name       = var.poolname
    node_count = var.nodecount
    vm_size    = var.nodesize
  }

#   default_node_pool {
#     name       = "pool2"
#     node_count = var.nodecount
#     vm_size    = var.nodesize
#   }

  

  

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks11.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks11.kube_config_raw

  sensitive = true
}