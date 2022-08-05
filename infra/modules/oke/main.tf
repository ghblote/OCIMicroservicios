# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_containerengine_cluster" "containerengine_cluster" {
  compartment_id = var.oke_compartment
  endpoint_config {
    is_public_ip_enabled = true
    subnet_id            = var.oke_public_subnet
    nsg_ids              = var.oke_cluster_nsg_ids
  }
  kubernetes_version = var.kubernetes_version
  name               = format("%s-oke-cluster", var.resource_abrv)
  vcn_id             = var.oke_vcn
  options {
    // TODO: Ask Richard why LB is on different public subnet than cluster subnet.
    service_lb_subnet_ids = [var.oke_public_subnet]
    add_ons {
      is_kubernetes_dashboard_enabled = "false"
      is_tiller_enabled               = "false"
    }
    admission_controller_options {
      is_pod_security_policy_enabled = "false"
    }
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
  }
}

resource "oci_containerengine_node_pool" "containerengine_node_pool" {
  cluster_id         = oci_containerengine_cluster.containerengine_cluster.id
  compartment_id     = var.oke_compartment
  kubernetes_version = var.kubernetes_version
  name               = format("%s-oke-pool", var.resource_abrv)
  node_shape         = var.pool_node_shape
  node_config_details {
    placement_configs {
      availability_domain = var.oke_availability_domain
      subnet_id           = var.oke_private_subnet
    }
    size    = "3"
    nsg_ids = var.oke_pool_nsg_ids
  }
  node_source_details {
    image_id    = local.oracle_linux_images.0 # Latest
    source_type = "IMAGE"
  }
}