
module "availability_domains" {
  source       = "../../../infra/modules/availability_domain"
  tenancy_ocid = var.tenancy_ocid
}

module "randoms" {
  source = "../../../infra/modules/random"
}