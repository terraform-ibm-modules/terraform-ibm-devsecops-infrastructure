##############################################################################
# Resource Group
##############################################################################

locals {
  resource_group_name = (var.existing_resource_group == "") ? var.resource_group : var.existing_resource_group
}

#Creation of a new resource group
resource "ibm_resource_group" "resource_group" {
  count = (var.existing_resource_group == "") ? 1 : 0
  name  = local.resource_group_name
}

#Data for an existing resource group
data "ibm_resource_group" "resource_group" {
  count = (var.existing_resource_group != "") ? 1 : 0
  name  = local.resource_group_name
}
