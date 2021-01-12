module "libvirt_pool" {
  source = "../../modules/libvirt-pool"

  name = var.subdomain
}

module "libvirt_network" {
  source = "../../modules/libvirt-network"

  name = var.subdomain
  cidr_range = "192.168.122.0/24"
  root_domain = "oswee.com"
}

module "bastion" {
  source = "../../modules/libvirt-domain"

  pool_name    = module.libvirt_pool.name
  network_id   = module.libvirt_network.id
  network_name = module.libvirt_network.name
  img_url      = "https://mirror.netsite.dk/fedora/linux/releases/33/Cloud/x86_64/images/Fedora-Cloud-Base-33-1.2.x86_64.qcow2"
}

module "vault" {
  source = "../../modules/vault"
}
