resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_policy" "admin_policy" {
  name    = "admin"
  policy  = file("policies/admin_policy.hcl")
}

resource "vault_policy" "dev_policy" {
  name    = "developer"
  policy  = file("policies/dev_policy.hcl")
}

