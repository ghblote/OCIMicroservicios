# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "ad1" {
  value = data.oci_identity_availability_domains.availability_domains.availability_domains[0].name
}

output "ad2" {
  value = data.oci_identity_availability_domains.availability_domains.availability_domains[1].name
}

output "ad3" {
  value = data.oci_identity_availability_domains.availability_domains.availability_domains[2
  ].name
}

output "ad_alf" {
  value = length(data.oci_limits_limit_values.limits_limit_values.limit_values.*.availability_domain) != 0 ? data.oci_limits_limit_values.limits_limit_values.limit_values[0].availability_domain : "N/A"
}