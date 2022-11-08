/**
 * # terraform-azurerm-private-endpoint
 *
 * Creates a new private endpoint for specified resource.
 * The module will perform a data lookup for the network detaisl from the `pe_network` input object.
 *
 * Future changes include:
 *   - 
 */

# ---------------------------------------------------------------------------
# Create a new Private Endpoint
# ---------------------------------------------------------------------------
resource "azurerm_private_endpoint" "pe" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.pe_resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "${var.private_endpoint_name}-connection"
    is_manual_connection           = false
    private_connection_resource_id = var.endpoint_resource_id
    subresource_names              = var.subresource_names
  }

  private_dns_zone_group {
    name                 = var.dns.zone_name
    private_dns_zone_ids = var.dns.zone_ids
  }
}
