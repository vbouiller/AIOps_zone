output "app_public_ip" {
  value = azurerm_linux_virtual_machine.app.public_ip_address
}

output "app_URL" {
  value = "http://${azurerm_linux_virtual_machine.app.public_ip_address}:5000"
}

output "app_username" {
  value = azurerm_linux_virtual_machine.app.admin_username
}

output "openai_endoint" {
  value = module.openai.openai_endpoint
}

output "openai_id" {
  value = module.openai.openai_id
}

output "openai_subdomain" {
  value = module.openai.openai_subdomain
}

output "openai_privateIP" {
  value = module.openai.private_ip_addresses
}