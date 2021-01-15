resource "vault_policy" "terraform_policy" {
  name   = "terraform"
  policy = data.local_file.terraform_policy.content
}

resource "vault_policy" "admin_policy" {
  name   = "admins"
  policy = data.local_file.admin_policy.content
}

resource "vault_policy" "developer_policy" {
  name   = "developers"
  policy = data.local_file.developer_policy.content
}

resource "vault_policy" "operations_policy" {
  name   = "operations"
  policy = data.local_file.operations_policy.content
}

