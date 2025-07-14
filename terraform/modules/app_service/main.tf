resource "azurerm_service_plan" "main" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"

  sku_name = "B1"
}

resource "azurerm_linux_web_app" "main" {
  name                = "${var.app_service_name}-${var.unique_suffix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    always_on = true
    app_command_line = "gunicorn app.app:app --bind 0.0.0.0:$PORT"

    application_stack {
      python_version = "3.9"
    }
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}
