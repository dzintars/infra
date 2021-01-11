resource "vault_policy" "admin_policy" {
  name    = "admins"
  policy  = file("./policies/policy.admin.hcl")
}

resource "vault_policy" "developer_policy" {
  name    = "developers"
  policy  = file("./policies/policy.developer.hcl")
}

resource "vault_policy" "operations_policy" {
  name    = "operations"
  policy  = file("./policies/policy.operations.hcl")
}


