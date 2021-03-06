variable "location" {
  description = "The Azure region where the private Endpoint should be created"
  type        = string
  default     = "uksouth"
  }


variable "pe_network" {
  description = "The required Azure networking details for the new Private Endpoint NIC."
  type = object({
    resource_group_name = string
    vnet_name           = string
    subnet_name         = string
    })
}

variable "pe_resource_name" {
  type = string
  default = "newblob"
}

variable "pe_resource_group_name" {
  description = "The name of the Resource group where the the Private Endpoint resource will be created."
  type        = string
}

variable "dns" {
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
  type = list(string)
  default = null
}
