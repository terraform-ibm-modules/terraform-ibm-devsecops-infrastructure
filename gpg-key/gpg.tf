data "external" "generate_gpg_secrets" {
  program = ["bash", "${path.module}/scripts/gpg_keys.sh"]

  query = {
    name     = var.gpg_name
    email    = var.gpg_email
  }
}

#resource "null_resource" "gpg_keys" {
#  depends_on = [data.external.generate_gpg_secrets]
#  triggers = {
#    always_run = "${timestamp()}"
#  }
#  provisioner "local-exec" {
#    command = "echo '${data.external.generate_gpg_secrets[0].result.signingkey}'"
#  } 
#}