# data "vault_auth_backend" "approle" {
#   path = "approle"
# }

# Create approle backend
resource "vault_auth_backend" "approle" {
  type = "approle"
  path = "approle"
}

data "vault_policy_document" "instance" {
  rule {
    path         = "ssh-host-signer/sign/instance"
    capabilities = ["update"]
    description  = "Allow hosts to sign their own certs"
  }
}

# Create the policy
resource "vault_policy" "instance" {
  name   = "instance"
  policy = data.vault_policy_document.instance.hcl
}

# Create the role and assign the policy
resource "vault_approle_auth_backend_role" "instance" {
  backend        = vault_auth_backend.approle.path
  role_name      = "instance"
  token_policies = ["default", vault_policy.instance.name]
}

# Create the secret which to inject into instance
resource "vault_approle_auth_backend_role_secret_id" "instance" {
  backend = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.instance.role_name
}

