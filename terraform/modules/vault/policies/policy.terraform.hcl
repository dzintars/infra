# Manage auth methods broadly across Vault
path "auth/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
  description  = ""
}

# Create, update, and delete auth methods
path "sys/auth/*"
{
  capabilities = ["create", "update", "delete", "sudo"]
  description  = ""
}

# List auth methods
path "sys/auth"
{
  capabilities = ["read"]
  description  = ""
}

# List existing policies
path "sys/policies/acl"
{
  capabilities = ["list"]
  description  = ""
}

# Create and manage ACL policies
path "sys/policies/acl/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
  description  = ""
}

# List, create, update, and delete key/value secrets
path "secret/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
  description  = ""
}

# Manage secrets engines
path "sys/mounts/*"
{
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
  description  = ""
}

# List existing secrets engines.
path "sys/mounts"
{
  capabilities = ["read"]
  description  = ""
}

# Read health checks
path "sys/health"
{
  capabilities = ["read", "sudo"]
  description  = ""
}

path "operations/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
  description  = ""
}

path "developers/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
  description  = ""
}
