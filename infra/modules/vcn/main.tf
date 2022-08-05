# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_vcn" "vcn" {
  compartment_id = var.vcn_compartment
  display_name   = format("%s-vcn", var.resource_abrv)
  cidr_block     = format("10.0.%d.0/24", var.vcn_class_c_address)
  is_ipv6enabled = var.vcn_is_ipv6enabled
  dns_label      = var.resource_abrv
}

#####################################################################
## Always Free + Paid Resources
#####################################################################
resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.vcn_compartment
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = format("%s-internet-gateway", var.resource_abrv)
}

resource "oci_core_route_table" "route_table_internet_gw" {
  compartment_id = var.vcn_compartment
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = format("%s-route-table-internet-gw", var.resource_abrv)
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}

resource "oci_core_subnet" "subnet_public" {
  compartment_id             = var.vcn_compartment
  vcn_id                     = oci_core_vcn.vcn.id
  display_name               = format("%s-subnet-public", var.resource_abrv)
  cidr_block                 = local.public_subnet_cidr
  route_table_id             = oci_core_route_table.route_table_internet_gw.id
  dhcp_options_id            = oci_core_vcn.vcn.default_dhcp_options_id
  dns_label                  = "publ"
  prohibit_public_ip_on_vnic = false
}

# #####################################################################
# ## Paid Resources
# #####################################################################
resource "oci_core_nat_gateway" "core_nat_gateway" {
  count          = var.vcn_create_private_subnet ? 1 : 0
  compartment_id = var.vcn_compartment
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = format("%s-nat-gateway", var.resource_abrv)
}

resource "oci_core_service_gateway" "core_service_gateway" {
  count          = var.vcn_create_private_subnet ? 1 : 0
  compartment_id = var.vcn_compartment
  services {
    service_id = data.oci_core_services.core_services.services[count.index].id
  }
  vcn_id       = oci_core_vcn.vcn.id
  display_name = format("%s-service-gateway", var.resource_abrv)
}

resource "oci_core_route_table" "route_table_private" {
  count          = var.vcn_create_private_subnet ? 1 : 0
  compartment_id = var.vcn_compartment
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = format("%s-route-table-nat-gw", var.resource_abrv)
  route_rules {
    description       = "NAT Gateway"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.core_nat_gateway[count.index].id
  }
  route_rules {
    description       = "Service Gateway"
    destination       = data.oci_core_services.core_services.services[count.index].cidr_block
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = oci_core_service_gateway.core_service_gateway[count.index].id
  }
}

resource "oci_core_subnet" "subnet_private" {
  count                      = var.vcn_create_private_subnet ? 1 : 0
  compartment_id             = var.vcn_compartment
  vcn_id                     = oci_core_vcn.vcn.id
  display_name               = format("%s-subnet-private", var.resource_abrv)
  cidr_block                 = local.private_subnet_cidr
  route_table_id             = oci_core_route_table.route_table_private[0].id
  dhcp_options_id            = oci_core_vcn.vcn.default_dhcp_options_id
  dns_label                  = "priv"
  prohibit_public_ip_on_vnic = true
  // This is to prevent the attempt to destroy the NSG before the subnet (VNIC attachment)
  depends_on = [
    oci_core_network_security_group.security_group_private
  ]
}