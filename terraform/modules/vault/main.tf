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

resource "tls_private_key" "example" {
  algorithm = "ECDSA"
  ecdsa_curve = "P521"
}

/* resource "vault_ssh_secret_backend_ca" "client_ca" { */
/*  backend		= vault_mount.ssh_client_signer.path */
/*   /1* generate_signing_key	= "true" *1/ */
/*   public_key  = "" */
/*   private_key = "" */
/* } */

resource "vault_ssh_secret_backend_ca" "client_ca" {
  backend		  = vault_mount.ssh_client_signer.path
  private_key = tls_private_key.example.private_key_pem
  public_key = tls_private_key.example.public_key_openssh
}

resource "vault_ssh_secret_backend_role" "clientrole" {
  name                    = "clientrole"
  backend                 = vault_mount.ssh_client_signer.path
  key_type                = "ca"
  allow_user_certificates = "true"
  allowed_users           = "*"
  allowed_extensions      = var.allowed_extensions
  default_extensions      = var.default_extensions
  default_user            = "dzintars"
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

