# TODO

- [ ] Ansible installation and setup
- [ ] How to easy monitor running service group? Let's say i want to quicly see are DHCP, DNS, TFTP, HAProxy and Matchbox running.
- [ ] Configure bridge network on workstation

- [X] i3wm
- [X] Compton
- [X] Polybar
- [X] i3lock + Blur
- [X] Fonts
- [X] Alacritty
- [X] ZSH + Oh My ZSH + Powerlevel10k
- [X] Certbot
- [X] HAproxy
- [X] Podman
- [X] Libvirt
- [ ] Nvidia
- [ ] Audio
- [ ] OBS Studio
- [ ] Pcmanfm
- [ ] Nvim
- [X] Code
- [ ] Chrome/Chromium
- [ ] Firefox
- [ ] Ranger
- [ ] Tmux
- [ ] Powerline
- [ ] NodeJS
- [ ] Yarn
- [ ] TypeScript
- [ ] Go
- [ ] gRPC
- [ ] Postman
- [ ] OpenVPN
- [ ] Rsync
- [ ] Slack
- [ ] Figma fonts
- [ ] Git
- [ ] Provide remove & cleanup tasks for every installed module/app.

- [ ] Remove i3status


systemctl status named-chroot dhcpd tftp haproxy matchbox firewalld

ps cax | grep -E "named-chroot|dhcpd|tftp" > /dev/null