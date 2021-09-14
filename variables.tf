# Copyright (c) 2020 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


variable "tenancy_id" {}
variable "user_id" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "default_compartment_id" {}

variable "vm_map" {
  description = "List of vms"
  type        = map(any)
  default     = { for x in ["vm1", "vm2"] : x => x }

}
