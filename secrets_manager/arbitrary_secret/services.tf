resource "ibm_sm_arbitrary_secret" "arbitrary_secret" {
  region          = var.region
  instance_id     = var.secrets_manager_guid
  secret_group_id = var.secret_group_id
  name            = var.secret_name
  description     = var.secret_description
  labels          = var.secret_labels
  payload         = var.secret_payload_password
  expiration_date = var.expiration_date
}
