variable "vnet_resource_group_name" {
  description = "The name of the Resource group where the vNET for the Private Endpoint exists."
  type        = string
}

variable "pe_resource_group_name" {
  description = "The name of the Resource group where the the Private Endpoint will be created. Typically the same Rg as the resource needing the endpoint."
  type        = string
}

variable "vnet_name" {
  description = "The name of the vNet where the Private Endpoint subnet is located."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet where the Private Endpoint will be created."
  type        = string
}

variable "subresource_names" {
  description = "A list of subresources that the private Endpoint is able to connect to. Refer to Azure documentation for full list."
  type        = list(string)
}

variable "dns" {
  type = object({
    zone_id   = string
    zone_name = string
    )}
}

variable "endpoint_resource" {
  type = object({
    id   = string
    name = string
    )}
}
