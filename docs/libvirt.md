# Libvirt

## Set custom libvirt storage pool location

By default openshift-install creates guest volumes in `/var/lib/libvirt/openshift-images`, but if you want to use other location, then the only way to do so is by creating symlink.

```sh
mkdir /home/user/kvm/pools/openshift-images
semanage fcontext -t virt_image_t -a '/home/user/kvm/pools/(/.*)?'
restorecon /home/user/kvm/pools

rmdir /var/lib/libvirt/openshift-images/
ln -s /home/user/kvm/pools/openshift-images/ /var/lib/libvirt/openshift-images
```

```sh
sudo groupadd --system libvirt
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt
id $(whoami)
sudo vim /etc/libvirt/libvirtd.conf
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"
sudo vim /etc/libvirt/qemu.conf
user = "dzintars"
group = "dzintars"
sudo systemctl restart libvirtd.service
```

In order to grant quemu access to my users directories i modified /etc/libvirt/qemu.conf file.

[Link to GitHub](https://github.com/jedi4ever/veewee/issues/996#issuecomment-536519623)


<ip address='10.50.1.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='10.50.1.10' end='10.50.1.254' />

      <host mac="52:54:00:20:00:00" ip="10.50.2.10"  name="vm-0.local" />

    </dhcp>
  </ip>