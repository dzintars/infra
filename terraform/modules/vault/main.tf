resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_mount" "ssh_client_signer" {
  description = "SSH Certs user key signer"
  path = "ssh-client-signer"
  type = "ssh"
}

resource "vault_mount" "ssh_host_signer" {
  description = "SSH Certs host signer"
  path = "ssh-host-signer"
  type = "ssh"
  max_lease_ttl_seconds = 315360000
}

resource "vault_ssh_secret_backend_ca" "ssh_backend" {
 backend		= vault_mount.ssh_client_signer.path
 generate_signing_key	= "true"
}

resource "vault_ssh_secret_backend_role" "ca_role" {
  name                    = "ca-role"
  backend                 = vault_mount.ssh_client_signer.path
  key_type                = "ca"
  allow_user_certificates = "true"
  allowed_users           = "*"
  allowed_extensions      = var.allowed_extensions
  default_extensions      = var.default_extensions
  default_user            = "fedora"
  cidr_list               = "0.0.0.0/0"
  ttl                     = "30m0s"
}

resource "vault_ssh_secret_backend_role" "hostrole" {
  name                    = "hostrole"
  backend                 = vault_mount.ssh_host_signer.path
  key_type                = "ca"
  allow_host_certificates = "true"
  allowed_domains         = "localdomain,oswee.com"
  allow_subdomains        = true
  ttl                     = "87600h"
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

