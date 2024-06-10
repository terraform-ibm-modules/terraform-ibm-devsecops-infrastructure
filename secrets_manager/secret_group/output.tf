output "secret_group_id" {
  value = try(ibm_sm_secret_group.sm_secret_group[0].secret_group_id, var.sm_existing_secret_group_id)
}

output "secret_group_name" {
  value = (var.sm_existing_secret_group_id == "") ? var.sm_secret_group_name : data.ibm_sm_secret_group.secret_group[0].name
}
