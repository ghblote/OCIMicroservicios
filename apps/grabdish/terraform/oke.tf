module "oke" {
  source                  = "../../../infra/modules/oke"
  resource_abrv           = local.resource_abrv
  oke_compartment         = var.compartment_ocid
  oke_vcn                 = module.vcn.vcn_id
  oke_public_subnet       = module.vcn.public_subnet_id
  oke_private_subnet      = module.vcn.private_subnet_id
  oke_availability_domain = module.availability_domains.ad1
  oke_pool_nsg_ids        = [module.vcn.private_nsg_id]
  oke_cluster_nsg_ids     = [module.vcn.private_nsg_id, module.vcn.lb_nsg_id]
}