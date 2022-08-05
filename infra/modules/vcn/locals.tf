locals {
  public_subnet_cidr  = format("10.0.%d.128/25", var.vcn_class_c_address)
  private_subnet_cidr = format("10.0.%d.0/25", var.vcn_class_c_address)
}