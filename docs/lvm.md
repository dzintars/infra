# LVM Logical Volume Management

Creating LVM volumes

 - Create physical volume
 - Define volume groups
 - Create logical volumes

Clear a Disk's Partition Table because you can't assign whole physical volume to LVM.
ATENTION! You will loose data by using `dd` utility.

```sh
dd if=/dev/zero of=/dev/sda bs=512 count=1
```

Define LVM Physical Volumes

```sh
pvcreate /dev/sda
```

```sh
pvscan -v
```

Create a Volume Group

```sh
vgcreate <vg-name> /dev/sda
vgextend <vg-name> /dev/sdb
pvscan -v
```

Define Logical Volumes

```sh
lvcreate -L 10G -n <volume-name> <vg-name>
```

WARNING: ntfs signature detected on /dev/raptor/test_vol at offset 3. Wipe it? [y/n]:

Make file system

```sh
mkfs -t ext4 /dev/raptor/test_vol
```

Mount Logical Volumes

```sh
mount -t ext4 /dev/raptor/test_vol /mnt/data
```
