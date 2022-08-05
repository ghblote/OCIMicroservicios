locals {
  compartment_ocid      = var.compartment_ocid != "" ? var.compartment_ocid : var.tenancy_ocid
  user_ocid             = var.user_ocid != "" ? var.user_ocid : var.current_user_ocid
  resource_abrv         = var.resource_abrv != "" ? var.resource_abrv : module.randoms.pet
  password              = var.password != "" ? var.password : module.randoms.password
  create_private_subnet = var.adb_secure_access_everywhere ? false : true
  adb_subnet            = var.adb_secure_access_everywhere ? module.vcn.public_subnet_id : module.vcn.private_subnet_id
}