output "secret_group_id" {
  value = try(ibm_sm_secret_group.sm_secret_group[0].secret_group_id, var.sm_secret_group_id)
}
