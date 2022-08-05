variable "resource_abrv" {}
variable "oke_vcn" {}
variable "oke_public_subnet" {}
variable "oke_private_subnet" {}
variable "oke_availability_domain" {}
variable "oke_compartment" {
  description = "The compartment to create the OKE in"
  type        = string
  default     = ""
}

variable "oke_pool_nsg_ids" {
  default = []
}

variable "oke_cluster_nsg_ids" {
  default = []
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use"
  type        = string
  default     = "v1.23.4"
}

variable "pool_node_shape" {
  description = "The OKE Pool Node Shape"
  type        = string
  default     = "VM.Standard.E2.1"
}