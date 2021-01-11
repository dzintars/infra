resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_policy" "admin_policy" {
  name    = "admins"
  policy  = file("policies/policy.admin.hcl")
}

resource "vault_policy" "developer_policy" {
  name    = "developers"
  policy  = file("policies/policy.developer.hcl")
}

resource "vault_policy" "operations_policy" {
  name    = "operations"
  policy  = file("policies/policy.operations.hcl")
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

resource "vault_generic_secret" "developer_sample_data" {
  path = "${vault_mount.developers.path}/test_account"
  data_json = <<EOT
{
  "username": "foo",
  "password": "bar"
}
EOT
}

