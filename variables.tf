variable "location" {
  description = "The Azure region where the private Endpoint will be created"
  type        = string
  default     = "uksouth"
  }


variable "pe_network" {
  description = "The details for the Azure network for the new Private Endpoint IP address."
  type = object({
    resource_group_name = string
    vnet_name           = string
    subnet_name         = string
    })
}

variable "private_endpoint_name" {
  type = string
  description = "The name to assign to the new private Endpoint."
}

variable "pe_resource_group_name" {
  description = "The name of the Resource group where the the Private Endpoint will be created."
  type        = string
}

variable "dns" {
  description = "The Details of the private DNS Zone where the Private Endpoint will register."
  type = object({
    zone_ids  = list(string)
    zone_name = string
    })
}

variable "endpoint_resource_id" {
  description = "The ID of the resource that the new Private Endpoint will be assigned to."
  type        = string
}

variable "subresource_names" {
  description = "list of subresource names which the Private Endpoint is able to connect to (eg, `blob` or `blob_secondary`), https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns"
  type = list(string)
  default = null
}
