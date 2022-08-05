# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

// Defaults
variable "resource_abrv" {}
variable "adb_license_model" {
  default = "LICENSE_INCLUDED"
}

variable "adb_version" {
  default = "19c"
}

variable "adb_is_always_free" {
  default = false
}

variable "adb_secure_access_everywhere" {
  description = "Enable mTLS (Wallet Required)"
}

variable "adb_subnet" {}

variable "adb_nsg_ids" {
  default = []
}

// Cloning Specific
variable "adb_source" {
  description = "Set if Cloning"
  type        = string
  default     = "NONE"
}

variable "adb_cpu_core_count" {
  description = "ADB Number of CPU Cores"
  type        = number
  default     = 1
}

variable "adb_data_storage_size_in_tbs" {
  description = "ADB Data Storage Size in TBs"
  type        = number
  default     = 1
}

// Carry through from main module
variable "adb_compartment" {
  description = "The compartment to create the ADB in"
  type        = string
  default     = ""
}

variable "adb_name" {
  description = "ADB Name. Must be unique."
  type        = string
  default     = ""
}

variable "adb_password" {
  description = "ADB ADMIN Password"
  default     = ""
}

variable "adb_source_id" {
  description = "Set if Cloning"
  default     = null
}

variable "adb_clone_type" {
  description = "Set if Cloning"
  default     = null
}