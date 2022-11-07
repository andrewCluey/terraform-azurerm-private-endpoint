#
```
terraform {
  # This module is now only being tested with Terraform 0.13.x. However, to make upgrading easier, we are setting
  # forwards compatible with 0.13.x code.
  required_version = ">= 0.13.0"
}

provider "azurerm" {
  features {}
}

module "private-endpoint_example_simple" {
  source  = "andrewCluey/private-endpoint/azurerm//examples/simple"
  version = "2.0.1"
  
  pe_resource_group_name = "network"        # Resource Group where the new Private Endpoint will be created. 
  subresource_names      = ["blob"]
  endpoint_resource_id   = "/subscriptions/787ytdg-foo-bar-id/resourceGroups/network/providers/Microsoft.Storage/storageAccounts/devstorageaccount1"
  
  # block of code to define the network where the new PE will be created. 
  pe_network = {
    resource_group_name = "network"
    vnet_name           = "core-vnet" 
    subnet_name         = "subnetA"
  }  
  
  dns = {
    zone_ids   = ["/subscriptions/787ytdg-foo-bar-id/resourceGroups/network/providers/Microsoft.Network/privateDnsZones/private.blob.zone"]
    zone_name  = "private.blob.zone"
  }
}
```
