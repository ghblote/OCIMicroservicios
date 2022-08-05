# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.tenancy_ocid
}

// Use Limits to determine if ALF and which AD is available for ALF
data "oci_limits_limit_values" "limits_limit_values" {
  compartment_id = var.tenancy_ocid
  service_name   = "compute"
  scope_type     = "AD"
  name           = "vm-standard-e2-1-micro-count"
  filter {
    name   = "value"
    values = ["2"]
  }
}