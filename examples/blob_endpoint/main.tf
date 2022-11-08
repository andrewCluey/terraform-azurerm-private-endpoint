
terraform {
  # This module is being tested with Terraform 1.3.0 or later.
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.20.0"
    }
  }
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
# Get Networking Data for a Private Endpoint
# ------------------------------------------------------------------------
data "azurerm_private_dns_zone" "blob_dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-dns"
}

data "azurerm_subnet" "sn" {
  name                 = "sn-a"
  virtual_network_name = "vn-spoke"
  resource_group_name  = "rg-network"
}

# -------------------------------------------------------------------
# Deploy the private Endpoint module with minimum input parameters.
# -------------------------------------------------------------------
module "private-endpoint_example_simple" {
  #using local module to test latest version
  source = "../../"

  pe_resource_group_name = azurerm_resource_group.rg.name
  private_endpoint_name  = "${azurerm_storage_account.sa.name}-pe"
  subresource_names      = ["blob"]
  endpoint_resource_id   = azurerm_storage_account.sa.id
  pe_subnet_id           = data.azurerm_subnet.sn.id


  dns = {
    zone_ids  = [data.azurerm_private_dns_zone.blob_dns.id]
    zone_name = data.azurerm_private_dns_zone.blob_dns.name
  }
}
