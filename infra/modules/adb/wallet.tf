# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_database_autonomous_database_wallet" "database_wallet" {
  count                  = var.adb_secure_access_everywhere ? 1 : 0
  autonomous_database_id = oci_database_autonomous_database.adb.id
  password               = var.adb_password
  base64_encode_content  = "true"
}

resource "local_sensitive_file" "database_wallet_file" {
  count          = var.adb_secure_access_everywhere ? 1 : 0
  content_base64 = oci_database_autonomous_database_wallet.database_wallet[0].content
  filename       = "${path.root}/wallet/Wallet_${var.adb_name}.zip"
}
