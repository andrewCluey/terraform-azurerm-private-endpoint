
terraform {
  # This module is being tested with Terraform 1.3.0 or later.
  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
}


# ------------------------------------------------------------------------
# Pre-requisites. Including a storage account for a blob private endpoint.
# ------------------------------------------------------------------------

resource "azurerm_resource_group" "rg" {
  name     = "rg-default-pe"
  location = "uksouth"
}

resource "azurerm_storage_account" "sa" {
  name                     = "examplestoragetftuf7"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

# ------------------------------------------------------------------------
# Get Data for a Private DNS zone to register the new PE IP address with.
# ------------------------------------------------------------------------
data "azurerm_private_dns_zone" "blob_dns" {
  name                = "privatelink.blob"
  resource_group_name = "rg-networking"
}


# -------------------------------------------------------------------
# Deploy the private Endpoint module with minimum input parameters.
# -------------------------------------------------------------------
module "private-endpoint_example_simple" {
  source  = "andrewCluey/private-endpoint"
  version = "2.0.1"
  
  pe_resource_group_name = azurerm_resource_group.rg.name
  subresource_names      = ["blob"]
  endpoint_resource_id   = azurerm_storage_account.sa.id
   
  pe_network = {
    resource_group_name = "network"
    vnet_name           = "core-vnet" 
    subnet_name         = "subnetA"
  }
  
  dns = {
    zone_ids   = [data.azurerm_private_dns_zone.blob_dns.id]
    zone_name  = data.azurerm_private_dns_zone.blob_dns.name
  }
}
