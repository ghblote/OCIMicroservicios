# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_database_autonomous_database" "adb" {
  admin_password              = var.adb_password
  compartment_id              = var.adb_compartment
  db_name                     = upper(var.adb_name)
  cpu_core_count              = var.adb_cpu_core_count
  data_storage_size_in_tbs    = var.adb_data_storage_size_in_tbs
  db_version                  = var.adb_version
  db_workload                 = "OLTP"
  display_name                = upper(var.adb_name)
  is_free_tier                = var.adb_is_always_free
  is_auto_scaling_enabled     = var.adb_is_always_free ? false : true
  is_mtls_connection_required = var.adb_secure_access_everywhere
  license_model               = var.adb_is_always_free ? "LICENSE_INCLUDED" : var.adb_license_model
  whitelisted_ips             = []
  nsg_ids                     = var.adb_nsg_ids
  subnet_id                   = var.adb_subnet
  source                      = var.adb_source
  source_id                   = var.adb_source_id
  clone_type                  = var.adb_clone_type
}