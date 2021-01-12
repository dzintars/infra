resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_auth_backend" "ssh_engine" {
  type = "ssh"
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

