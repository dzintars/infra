resource "libvirt_network" "network" {
  name      = var.name
  mode      = "nat"
  /* domain    = "${var.hostname}.${var.subdomain}.${var.root_domain}" */
  domain    = var.root_domain
  addresses = [var.cidr_range]
  dhcp {
    enabled = true
  }
  dns {
    enabled = true
  }
}
