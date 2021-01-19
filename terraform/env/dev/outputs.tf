output "bastion_ip" {
  description = "The IP address of the Bastion Server"
  value       = module.bastion.instance_ip_addr
}

output "vault_ssh_client_public_key" {
  description = "SSH Client CA Public Key"
  value       = module.vault.client_ca_public_key
}
