# TODO

- [ ] Ansible installation and setup
- [ ] How to easy monitor running service group? Let's say i want to quicly see are DHCP, DNS, TFTP, HAProxy and Matchbox running.
- [ ] Configure bridge network on workstation
- [ ] Setup Go environment including gRPC and it's plugins.
- [ ] VS Code installation
- [ ] i3wm installation and setup
- [ ] Compton installation and setup
- [ ] Polybar
- [ ] i3lock
- [ ] Nvidia
- [ ] Audio
- [ ] OBS Studio
- [ ] Provide remove & cleanup tasks for every installed module/app.

systemctl status named-chroot dhcpd tftp haproxy matchbox firewalld

ps cax | grep -E "named-chroot|dhcpd|tftp" > /dev/null