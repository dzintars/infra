output "bastion_ip" {
  description = "The IP address of the Bastion Server"
  value       = module.bastion.instance_ip_addr
}

