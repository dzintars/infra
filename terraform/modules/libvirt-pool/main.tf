resource "libvirt_pool" "pool" {
  name = var.name
  type = "dir"
  path = "/var/lib/libvirt/pools/terraform-provider-pool-${var.name}"
}


