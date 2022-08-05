# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "vcn" {
  source                    = "../../../infra/modules/vcn"
  resource_abrv             = local.resource_abrv
  vcn_compartment           = local.compartment_ocid
  vcn_class_c_address       = module.randoms.integer
  vcn_create_private_subnet = local.create_private_subnet
}