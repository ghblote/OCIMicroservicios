#####################################################################
## NSG on Private Subnet - Let the Private Subnet talk amongst itself privately
#####################################################################
resource "oci_core_network_security_group" "security_group_private" {
  count          = var.vcn_create_private_subnet ? 1 : 0
  compartment_id = var.vcn_compartment
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = format("%s-security-group-private", var.resource_abrv)
}

// Private Subnet - EGRESS
resource "oci_core_network_security_group_security_rule" "security_group_private_egress" {
  count                     = var.vcn_create_private_subnet ? 1 : 0
  network_security_group_id = oci_core_network_security_group.security_group_private[0].id
  direction                 = "EGRESS"
  protocol                  = "all"
  destination               = local.private_subnet_cidr
  destination_type          = "CIDR_BLOCK"
}

// Private Subnet - INGRESS
resource "oci_core_network_security_group_security_rule" "security_group_private_ingress" {
  count                     = var.vcn_create_private_subnet ? 1 : 0
  network_security_group_id = oci_core_network_security_group.security_group_private[0].id
  direction                 = "INGRESS"
  protocol                  = "all"
  source                    = local.private_subnet_cidr
  source_type               = "CIDR_BLOCK"
}

#####################################################################
## NSG on Public LBaaS - World to Ports 80 and 443
#####################################################################
resource "oci_core_network_security_group" "security_group_lb" {
  compartment_id = var.vcn_compartment
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = format("%s-security-group-lb", var.resource_abrv)
}
// Security Group for Load Balancer (lb) - EGRESS
resource "oci_core_network_security_group_security_rule" "security_group_lb_egress" {
  network_security_group_id = oci_core_network_security_group.security_group_lb.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}
// Security Group for Load Balancer (lb) - INGRESS
resource "oci_core_network_security_group_security_rule" "security_group_lb_ingress_TCP80" {
  network_security_group_id = oci_core_network_security_group.security_group_lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 80
      min = 80
    }
  }
}
resource "oci_core_network_security_group_security_rule" "security_group_lb_ingress_TCP443" {
  network_security_group_id = oci_core_network_security_group.security_group_lb.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 443
      min = 443
    }
  }
}

# #####################################################################
# ## NSG on OKE Node Pool on Private Subnet
# #####################################################################
# resource "oci_core_network_security_group" "security_group_oke_nodepool" {
#   compartment_id = var.vcn_compartment
#   vcn_id         = oci_core_vcn.vcn.id
#   display_name   = format("%s-security-group-oke-nodepool", var.resource_abrv)
# }
# resource "oci_core_network_security_group_security_rule" "security_group_oke_nodepool_ingress_icmp" {
#   network_security_group_id = oci_core_network_security_group.security_group_oke_nodepool.id
#   description = "Path discovery"
#   direction                 = "INGRESS"
#   protocol                  = "1"
#   source                    = oci_core_subnet.subnet_public.cidr_block
#   source_type               = "CIDR_BLOCK"
#     icmp_options {
#       code = "4"
#       type = "3"
#     }
# }
# resource "oci_core_network_security_group_security_rule" "security_group_oke_nodepool_ingress_icmp" {
#   network_security_group_id = oci_core_network_security_group.security_group_oke_nodepool.id
#   description = "TCP access from Kubernetes Control Plane"
#   direction                 = "INGRESS"
#   protocol                  = "6"
#   source                    = oci_core_subnet.subnet_public.cidr_block
#   source_type               = "CIDR_BLOCK"
# }

# # #####################################################################
# # ## NSG on OKE Cluster on Public Subnet
# # #####################################################################
# resource "oci_core_network_security_group" "security_group_oke_cluster" {
#   compartment_id = var.vcn_compartment
#   vcn_id         = oci_core_vcn.vcn.id
#   display_name   = format("%s-security-group-oke-cluster", var.resource_abrv)
# }

# # #####################################################################
# # ## DB NSG on Public Subnet - Free Resource
# # #####################################################################
# # resource "oci_core_security_list" "security_group_oke_endpoint" {
# #   compartment_id = var.vcn_compartment
# #   vcn_id         = oci_core_vcn.vcn.id
# #   display_name   = format("%s-security-group-oke-endpoint", var.resource_abrv)
# #   egress_security_rules {
# #     description      = "All traffic to worker nodes"
# #     destination      = local.nodepool_cidr_block
# #     destination_type = "CIDR_BLOCK"
# #     protocol         = "6"
# #     stateless        = "false"
# #   }
# #   egress_security_rules {
# #     description      = "Path discovery"
# #     destination      = local.nodepool_cidr_block
# #     destination_type = "CIDR_BLOCK"
# #     icmp_options {
# #       code = "4"
# #       type = "3"
# #     }
# #     protocol  = "1"
# #     stateless = "false"
# #   }
# #   ingress_security_rules {
# #     description = "External access to Kubernetes API endpoint"
# #     protocol    = "6"
# #     source      = "0.0.0.0/0"
# #     source_type = "CIDR_BLOCK"
# #     stateless   = "false"
# #     tcp_options {
# #       max = "6443"
# #       min = "6443"
# #     }
# #   }
# #   ingress_security_rules {
# #     description = "Kubernetes worker to control plane communication"
# #     protocol    = "6"
# #     source      = local.nodepool_cidr_block
# #     source_type = "CIDR_BLOCK"
# #     stateless   = "false"
# #     tcp_options {
# #       max = "12250"
# #       min = "12250"
# #     }
# #   }
# #   ingress_security_rules {
# #     description = "Path discovery"
# #     icmp_options {
# #       code = "4"
# #       type = "3"
# #     }
# #     protocol    = "1"
# #     source      = local.nodepool_cidr_block
# #     source_type = "CIDR_BLOCK"
# #     stateless   = "false"
# #   }
# # }