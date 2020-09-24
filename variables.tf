variable "pe_vnet_resource_group_name" {
  description = "The name of the Resource group where the vNET for the Private Endpoint exists."
  type        = string
}

variable "pe_resource_group_name" {
  description = "The name of the Resource group where the the Private Endpoint will be created. Typically the same Rg as the resource needing the endpoint."
  type        = string
}

variable "pe_vnet_name" {
  description = "The name of the vNet where the Private Endpoint subnet is located."
  type        = string
}

variable "pe_subnet_name" {
  description = "The name of the subnet where the Private Endpoint will be created."
  type        = string
}

variable "subresource_names" {
  description = "A list of subresources that the private Endpoint is able to connect to. Refer to Azure documentation for full list."
  type        = list(string)
  default     = []
}


variable "private_dns_zone_name" {
  description = "The name of the privatelink DNS zone in Azure to register the Private Endpoints"
  type        = string
}

variable "private_dns_zone_id" {
  description = "The ID of the privatelink DNS zone in Azure to register the Private Endpoint. Use a Data lookup block in the calling code if not known."
  type        = list(string)
  default     = []
}

variable "pe_resource_id" {
  description = "The ID of the Resource that will have the new Private Endpoint Assigned."
  type        = string
}

variable "pe_resource_name" {
  description = "The Name of the Resource that will have the new Private Endpoint Assigned."
  type        = string
}
