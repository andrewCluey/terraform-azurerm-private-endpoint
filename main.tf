#########################################################
# Creates a New Private Endpoint for a specified Resource
#########################################################

##############
# Data Lookups
##############

# Subnet where PE is to be created
data "azurerm_subnet" "pe_subnet" {
  name                 = var.pe_network.subnet_name
  virtual_network_name = var.pe_network.vnet_name
  resource_group_name  = var.pe_network.resource_group_name
}

# Resource Group where the private Endpoint will reside.
data "azurerm_resource_group" "pe_rg" {
  name = var.pe_resource_group_name
}

###############################
# Create a new Private Endpoint
###############################
resource "azurerm_private_endpoint" "pe" {
  name                = "${var.pe_resource_name}-pe"
  location            = var.location
  resource_group_name = var.pe_resource_group_name
  subnet_id           = data.azurerm_subnet.pe_subnet.id

  private_service_connection {
    name                           = "${var.pe_resource_name}-connection"
    is_manual_connection           = false
    private_connection_resource_id = var.endpoint_resource.id
  }

  private_dns_zone_group {
    name                 = var.dns.zone_name
    private_dns_zone_ids = var.dns.zone_id
  }
}

