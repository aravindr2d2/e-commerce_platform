provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "East US"
}

resource "azurerm_app_service_plan" "ap1" {
  name                = "myAppServicePlan"
  location            = azurerm_resource_group.ap1.location
  resource_group_name = azurerm_resource_group.ap1.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "ap2" {
  name                = "myAppName"
  location            = azurerm_resource_group.ap2.location
  resource_group_name = azurerm_resource_group.ap2.name
  app_service_plan_id = azurerm_app_service_plan.ap2.id

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    WEBSITES_PORT                       = "3000"
  }

  site_config {
    linux_fx_version = "DOCKER|my-docker-repo/my-app:latest"
  }
}
