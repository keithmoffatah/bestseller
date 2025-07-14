module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "app_service" {
  source                  = "./modules/app_service"
  resource_group_name     = module.resource_group.resource_group_name
  location                = var.location
  app_service_plan_name   = var.app_service_plan_name
  app_service_name        = var.app_service_name
  unique_suffix           = var.unique_suffix
}
