provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "West Europe"
  tags = {
    dev = "true"
  }
}

resource "azurerm_storage_account" "example" {
  name                     = "exampleteststorageacct"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"
  tags = {
    dev = "true"
  }
}

resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  tenant_id                   = "6df5d9b1-2807-4c12-a223-63909d98a6f2"
  sku_name                    = "standard"
  tags = {
    dev = "true"
  }
}

resource "azurerm_service_plan" "example" {  
  name                = "example-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku_name            = "B1"
  os_type             = "Linux"
  tags = {
    dev = "true"
  }
}

resource "azurerm_windows_web_app" "example" {
  name                = "example-test-app-service"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.example.instrumentation_key
  }
  
  tags = {
    dev = "true"
  }

  site_config {}
}

resource "azurerm_application_insights" "example" {
  name                = "example-appinsights"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "web"
  tags = {
    dev = "true"
  }
}

resource "azurerm_mssql_server" "example" {
  name                         = "exampletestsqlserver"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "H@Sh1CoR3!"
  tags = {
    dev = "true"
  }
}

resource "azurerm_mssql_database" "example" {
  name      = "exampledb"
  server_id = azurerm_mssql_server.example.id
  sku_name  = "Basic"
  tags = {
    dev = "true"
  }
}
