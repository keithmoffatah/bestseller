// Used to reference module that will output the default site hostname of the Azure App Service
output "app_service_default_hostname" {
  value = module.app_service.default_site_hostname
}
