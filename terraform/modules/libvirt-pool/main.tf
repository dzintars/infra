resource "libvirt_pool" "pool" {
  name = var.name
  type = "dir"
  path = "/tmp/terraform-provider-libvirt-pool-${var.name}"
}


