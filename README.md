<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-private-endpoint

Creates a new private endpoint for specified resource.
The module will perform a data lookup for the network detaisl from the `pe_network` input object.

Future changes include:
  -

## Example - create a Private Endpoint for a Blob endpoint of a Storage Account.
This example creates a new Storage Account, to create a Private Endpoint for a Blob Endpoint using an existing Subnet.
```hcl

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
```

## Subresource name types
|Resource Type|Subresource name|Secondary Subresource name|
|---|---|---|
|Data Lake File System Gen2	|dfs	|dfs_secondary|
|Sql Database / Data Warehouse	|sqlServer	|
|Storage Account	|blob	|blob_secondary|
|Storage Account	|file	|file_secondary|
|Storage Account	|queue	|queue_secondary|
|Storage Account	|table	|table_secondary|
|Storage Account	|web	|web_secondary|

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns"></a> [dns](#input\_dns) | The Details of the private DNS Zone where the Private Endpoint will register. | <pre>object({<br>    zone_ids  = list(string)<br>    zone_name = string<br>  })</pre> | n/a | yes |
| <a name="input_endpoint_resource_id"></a> [endpoint\_resource\_id](#input\_endpoint\_resource\_id) | The ID of the resource that the new Private Endpoint will be assigned to. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the private Endpoint will be created | `string` | `"uksouth"` | no |
| <a name="input_pe_resource_group_name"></a> [pe\_resource\_group\_name](#input\_pe\_resource\_group\_name) | The name of the Resource group where the the Private Endpoint will be created. | `string` | n/a | yes |
| <a name="input_pe_subnet_id"></a> [pe\_subnet\_id](#input\_pe\_subnet\_id) | The ID of the Subnet where the Private Endpoint IP address will be created. | `string` | n/a | yes |
| <a name="input_private_endpoint_name"></a> [private\_endpoint\_name](#input\_private\_endpoint\_name) | The name to assign to the new private Endpoint. | `string` | n/a | yes |
| <a name="input_subresource_names"></a> [subresource\_names](#input\_subresource\_names) | list of subresource names which the Private Endpoint is able to connect to (eg, `blob` or `blob_secondary`), https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pe_name"></a> [pe\_name](#output\_pe\_name) | n/a |
<!-- END_TF_DOCS -->