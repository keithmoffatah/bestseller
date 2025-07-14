// Used to output the default site hostname of the Azure App Service
output "default_site_hostname" {
  value = azurerm_linux_web_app.main.default_hostname
}
