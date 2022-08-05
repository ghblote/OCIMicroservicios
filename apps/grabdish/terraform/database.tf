module "adb" {
  count                        = 2
  source                       = "../../../infra/modules/adb"
  resource_abrv                = local.resource_abrv
  adb_compartment              = var.compartment_ocid
  adb_name                     = format("%s%d", local.resource_abrv, count.index + 1)
  adb_password                 = local.password
  adb_secure_access_everywhere = var.adb_secure_access_everywhere
  adb_subnet                   = local.adb_subnet
  adb_nsg_ids                  = [module.vcn.private_nsg_id]
}