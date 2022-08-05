# Copyright © 2020, Oracle and/or its affiliates. 
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

output "pet" {
  value = random_pet.prefix.id
}

output "password" {
  value = random_password.password.result
}

output "integer" {
  value = random_integer.integer.result
}