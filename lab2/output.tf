output "web-subnet-id" {
  value = azurerm_subnet.subnet1.id
}


output "db-subnet-id" {
  value = azurerm_subnet.subnet2.id
}