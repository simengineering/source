# ---- Get the list of available ADs
data "oci_identity_availability_domains" "ADs" {
compartment_id = "${var.tenancy_id}"
}


# ---- Create a new Virtual Cloud Network
variable "vcn_cidr" { default = "10.0.0.0/16" }
resource "oci_core_vcn" "newVCN" {
  cidr_block     = "${var.vcn_cidr}"
  dns_label      = "vcn1"
  compartment_id = var.default_compartment_id
  display_name   = "new-VCN"
}
output "vcn_id" {
  value = oci_core_vcn.newVCN.id
}

output "vcn_cidr" {
  description = "CIDR block of the core VCN"
  value       = oci_core_vcn.newVCN.cidr_block
}

# ---- Create a new Internet Gateway

resource "oci_core_internet_gateway" "newIG" {
  compartment_id = var.default_compartment_id
  display_name   = "new-internet-gateway"
  vcn_id         = oci_core_vcn.newVCN.id
}

# ---- Create a new Route Table

resource "oci_core_route_table" "newRT" {
  compartment_id = var.default_compartment_id
  vcn_id         = oci_core_vcn.newVCN.id
  display_name   = "new-route-table"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.newIG.id

  }
}
