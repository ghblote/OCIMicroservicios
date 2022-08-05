# Copyright © 2020, Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "adb_id" {
  value = oci_database_autonomous_database.adb.id
}

output "adb_name" {
  value = oci_database_autonomous_database.adb.db_name
}
