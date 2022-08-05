# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

// Basic Hidden - Taken from Env/RMS
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
variable "user_ocid" {
  default = ""
}
variable "current_user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "private_key" {
  default = ""
}

// User Input
variable "resource_abrv" {
  default = "grabdish"
}
variable "password" {
  default = ""
}

// ADB Defaults
variable "adb_secure_access_everywhere" {
  description = "Enable mTLS (Wallet Required); Private Subnet not Required"
  default     = true
}