resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_mount" "ssh_engine" {
  path = "ssh-client-signer"
  type = "ssh"
  description = "SSH Certs signer"
}

resource "vault_ssh_secret_backend_ca" "ssh_backend" {
 backend		= vault_mount.ssh_engine.path
 generate_signing_key	= "true"
}

resource "vault_ssh_secret_backend_role" "bar" {
  name                    = "ca-role"
  backend                 = vault_mount.ssh_engine.path
  key_type                = "ca"
  allow_user_certificates = "true"
  allowed_extensions      = var.allowed_extensions
  default_extensions      = var.default_extensions
  default_user            = "fedora"
  allowed_users           = "*"
  cidr_list               = "0.0.0.0/0"
  ttl                     = "30m0s"
}

resource "vault_mount" "developers" {
  path = "developers"
  type = "kv-v2"
  description = "KV2 Secrets Engine for Developers"
}

resource "vault_mount" "operations" {
  path = "operations"
  type = "kv-v2"
  description = "KV2 Secrets Engine for Operations"
}

/* resource "vault_generic_secret" "developer_sample_data" { */
/*   path = "${vault_mount.developers.path}/test_account" */
/*   data_json = <<EOT */
/* { */
/*   "username": "foo", */
/*   "password": "bar" */
/* } */
/* EOT */
/* } */

