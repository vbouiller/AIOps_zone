output "app_public_ip" {
  value = azurerm_linux_virtual_machine.app.public_ip_address
}

output "app_URL" {
  value = "http://${output.app_public_ip}:5000"
}

output "app_username" {
  value = azurerm_linux_virtual_machine.app.admin_username
}