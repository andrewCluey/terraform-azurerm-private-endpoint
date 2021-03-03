# terraform-azurerm-private-endpoint
Create a Private Endpoint for an Azure Resource.


# Examples
```hcl

module "private-endpoint" {
  source  = "andrewCluey/private-endpoint/azurerm"
  version = "1.0.0"
  
  pe_resource_group_name = "resourceGroup"
  endpoint_resource_id = "id_of_the_resource-to-assign-PE-to"
  
  pe_network = {
    resource_group_name = "vnet_resourcegroup"
    vnet_name           = "vnet_name" 
    subnet_name         = "subnetName-fortheNewPE" 
  }  
  
  dns = {
    zone_id   = "long\id\ofthePrivateDENSZONE\ID"
    zone_name = "private.dns.zoneName"
  }
}

```
