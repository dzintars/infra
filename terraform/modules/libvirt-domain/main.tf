resource "libvirt_volume" "volume" {
  count  = var.instance_count
  name   = "${var.hostname}-${count.index}-${var.subdomain}.${var.img_format}"
  pool   = var.pool_name
  source = var.img_url
  format = var.img_format
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name           = "${var.hostname}_cloudinit.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = var.pool_name
}

resource "libvirt_domain" "domain" {
  count  = var.instance_count
  name   = "${var.hostname}.${var.subdomain}.${var.root_domain}"
  memory = "1024"
  vcpu   = 1
  arch   = "x86_64"

  cpu = {
    mode = "host-passthrough"
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  network_interface {
    network_id   = var.network_id
    network_name = var.network_name
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  disk {
    volume_id = libvirt_volume.volume[count.index].id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
