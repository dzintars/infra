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