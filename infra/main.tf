terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "eastus"
  tags = {
    Environment = var.env_tag
  }
}

# # file share
# resource "azurerm_storage_account" "storageaccount" {
#   name                     = "aksefkstorageaccount"
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = azurerm_resource_group.rg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# resource "azurerm_storage_share" "fileshare" {
#   name                 = "aksefkfileshare"
#   storage_account_name = azurerm_storage_account.storageaccount.name
#   quota                = 50
# }


# aks
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksefkerictest"

  default_node_pool {
    name                = "default"
    node_count          = 2
    vm_size             = "Standard_D2s_v5"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 4
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.env_tag
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count

    ]
  }
}
