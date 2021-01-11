data "local_file" "admin_policy" {
  filename = "${path.module}/policies/policy.admin.hcl"
}

data "local_file" "developer_policy" {
  filename = "${path.module}/policies/policy.developer.hcl"
}

data "local_file" "operations_policy" {
  filename = "${path.module}/policies/policy.operations.hcl"
}
