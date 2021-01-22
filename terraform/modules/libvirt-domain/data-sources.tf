data "template_file" "user_data" {
  template = file("${path.module}/templates/cloud_init.tpl")
  vars = {
    user         = var.user
    hostname     = var.hostname
    subdomain    = var.subdomain
    root_domain  = var.root_domain
    time_zone    = var.time_zone
    vault_addr   = var.vault_addr
    role_id      = var.vault_role_id
    secret_id    = var.vault_secret_id
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/templates/network_config_dhcp.tpl")
}
