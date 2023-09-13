provider "azurerm" {
  features {}  
}

terraform {
  backend "azurerm" {
    storage_account_name = "__terraformstorageaccount__"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
     
    access_key = "__storagekey__"
    features {}
  } 
}
resource "azurerm_resource_group" "dev"{
name  = "terraform_rg"
location = "East us"
}

resource "azurerm_app_service_plan" "dev" {
  name                = "tfserviceplan"
  location            = "${azurerm_resource_group.dev.location}"
  resource_group_name = "${azurerm_resource_group.dev.name}"

sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "dev" {
name                = "tfwebapp"
location            = "${azurerm_resource_group.dev.location}"
resource_group_name = "${azurerm_resource_group.dev.name}"

}

