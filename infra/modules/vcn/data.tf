data "oci_core_services" "core_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
}

data "oci_core_service_gateways" "core_service_gateways" {
  compartment_id = var.vcn_compartment
  vcn_id         = oci_core_vcn.vcn.id
}