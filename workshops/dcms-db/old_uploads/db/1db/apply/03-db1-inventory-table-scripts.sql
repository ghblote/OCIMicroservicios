-- Copyright (c) 2021 Oracle and/or its affiliates.
-- Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


WHENEVER SQLERROR EXIT 1
connect $INVENTORY_USER/"$INVENTORY_PASSWORD"@$DB1_ALIAS

@../../common/apply/inventory-table.sql
@../../common/apply/inventory-messaging.sql
@../../common/apply/inventory-db-plsql.sql
@../../common/apply/inventory-db-deploy.sql
