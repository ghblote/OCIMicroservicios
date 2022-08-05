# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_objectstorage_bucket" "objectstorage_bucket" {
  compartment_id = var.objectstorage_compartment
  namespace      = data.oci_objectstorage_namespace.ns.namespace
  name           = format("%s-bucket", var.resource_abrv)
  access_type    = "NoPublicAccess"
  auto_tiering   = "Disabled"
}