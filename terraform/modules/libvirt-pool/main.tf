resource "libvirt_pool" "pool" {
  name = var.name
  type = "dir"
  path = "$HOME/kvm/pools/terraform-provider-pool-${var.name}"
}


