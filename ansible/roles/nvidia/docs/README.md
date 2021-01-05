# README

**WARNING:** Before running this role, make sure you do the following (not automated yet):

Stolen from https://gist.github.com/Rambou/c6769caee19b0b9915d8342b86c3ef72 :)

If, like me, your are booting with UEFI (because having a triple boot ubuntu-windows-mac or because UEFI is the most modern type of bootloader and successor of EFI :p), you have to sign the proprietary modules each time they are recompiled (or upgrade kernel version) so that they are allowed to be loaded in the kernel.

## 1) Step one, create a self-signed certificate to sign nvidia driver:

```sh
sudo openssl req -new -x509 -newkey rsa:2048 -keyout UEFI.key -outform DER -out UEFI.der -nodes -days 36500 -subj "/CN=dzintars_nvidia/"
```

## 2) step two load and store certificate in a supplementary key database MOC

```sh
sudo mokutil --import UEFI.der
```

## 3) step three reboot your system

At this step after reboot you will be prompted to select your certificate to import in in key database. If you have inserted a password at certificate creation you'll be prompted to insert it. If you are not prompted, you may have to enter the BIOS by using function keys at boot time.

## 4) Now we can install our nvidia driver

But first let us take a selfie... no seriously we need to take a selfi with our lovely linux installation because it can be fucked...
just kidding :D, it will not!

## 5) Before we install we first need to uninstall previous drivers, probably nouveau.

```sh
sudo dnf remove nvidia* && sudo dnf autoremove
sudo vim /etc/modprobe.d/blacklist-nouveau.conf
```

and add lines below

```sh
blacklist nouveau
blacklist lbm-nouveau
options nouveau modeset=0
alias nouveau off
alias lbm-nouveau off
```

disable the Kernel Nouveau by typing these lines in a terminal window:

```sh
echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
```

and after that

```sh
update-initramfs -u
```

Now you can reboot your computer, and when you get to the login prompt, press Ctrl+Alt+F1 to exit to the terminal console. Login with your username and password. stop your display manager or the X server,

```sh
sudo service lightdm stop
```

## 7) finall step install nvidia drivers

```sh
sh ./NVIDIA-Linux-x86-319.32.run -s --module-signing-secret-key=/path/to/UEFI.key --module-signing-public-key=/path/to/UEFI.der
```

Information about installing nvidia driver in ubuntu xenial-xerus can be found in this post
https://linuxconfig.org/how-to-install-the-latest-nvidia-drivers-on-ubuntu-16-04-xenial-xerus

Information about installing and signing nvidia driver can be found in the official nvidia website.
http://us.download.nvidia.com/XFree86/Linux-x86/319.32/README/installdriver.html

Information about uninstall nouveau and disable xorg (answer)
http://askubuntu.com/questions/451221/how-do-i-install-the-nvidia-driver-for-a-geforce-gt-630

Information about backup or restore if something goes wrong
http://askubuntu.com/questions/760997/how-to-recover-from-a-nvidia-fail-on-ubuntu-16-04

## Installation

To see the output logs:

```sh
cat /var/log/nvidia-installer.log
```

Install driver from the root home

```sh
./Downloads/NVIDIA-Linux-x86_64-450.66.run -s --module-signing-secret-key=/home/dzintars/UEFI.key --module-signing-public-key=/home/dzintars/UEFI.der
```

Be sure paths to the files is correct. Remember that you are executing from the root's home directory.

Could be asked to uninstall existing Nvidia drivers (look at the logs):

```sh
./Downloads/NVIDIA-Linux-x86_64-450.66.run --uninstall # If this fails then use:
dnf remove xorg-x11-drv-nvidia\* kmod-nvidia\*
```

In my case I didn't got terminal GUI to install the driver (blue windows), but by checking logs I saw that installations was successful.
