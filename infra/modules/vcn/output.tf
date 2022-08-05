# Copyright © 2020, Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "vcn_id" {
  value = oci_core_vcn.vcn.id
}

output "private_subnet_id" {
  value = var.vcn_create_private_subnet ? oci_core_subnet.subnet_private[0].id : null
}

output "private_subnet_cidr" {
  value = var.vcn_create_private_subnet ? oci_core_subnet.subnet_private[0].cidr_block : null
}

output "public_subnet_id" {
  value = oci_core_subnet.subnet_public.id
}

output "public_subnet_cidr" {
  value = oci_core_subnet.subnet_public.cidr_block
}

output "private_nsg_id" {
  value = var.vcn_create_private_subnet ? oci_core_network_security_group.security_group_private[0].id : null
}

output "lb_nsg_id" {
  value = oci_core_network_security_group.security_group_lb.id
}