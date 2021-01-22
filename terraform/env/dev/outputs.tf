output "bastion_ip" {
  description = "The IP address of the Bastion Server"
  value       = module.bastion.instance_ip_addr
}

output "vault_ssh_client_public_key" {
  description = "SSH Client CA Public Key"
  value       = module.vault-ssh.client_ca_public_key
}

output "approle" {
  description = "Instance approle parameters"
  value = {
    id = module.vault-ssh.approle.id
    role = module.vault-ssh.approle.role_id
    secret = module.vault-ssh.approle.secret_id
  }
}
