# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

// Defaults
variable "vcn_is_ipv6enabled" {
  description = "Enable IPv6 on VCN"
  type        = bool
  default     = false
}

variable "vcn_enable_igw" {
  description = "Enable Internet Gateway"
  type        = bool
  default     = true
}

variable "vcn_create_private_subnet" {
  description = "Create Private Subnet"
  type        = bool
  default     = false
}

// Dynamic for Module
variable "resource_abrv" {
  description = "Application Resource Abbreviation"
  type        = string
  default     = ""
}
variable "vcn_compartment" {
  description = "The compartment to create the VCN in"
  type        = string
  default     = ""
}
variable "vcn_class_c_address" {
  description = "The Class C block to create the VCN in"
  type        = number
  default     = 0
}