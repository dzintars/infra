# Manage auth methods broadly across Vault
path "*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
  description  = "Allows Terraform to manage paths broadly across Vault."
}

