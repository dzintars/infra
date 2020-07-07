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
- [X] Pcmanfm
- [X] Nvim
- [X] Code
- [X] Chrome/Chromium
- [ ] Firefox
- [X] Ranger
- [X] Tmux + Powerline
- [X] NodeJS
- [X] Yarn
- [ ] TypeScript
- [ ] Go
- [ ] gRPC
- [ ] ProtoC
- [ ] Postman (https://dl.pstmn.io/download/latest/linux64)
- [ ] OpenVPN
- [X] Rsync
- [X] Git
- [X] Blender
- [X] Slack
- [ ] Skype
- [ ] Dunst
- [X] KeePassXC
- [ ] Gimp
- [X] LibreOffice
- [ ] qBittorrent
- [X] Remmina
- [ ] TeamViewer
- [ ] Figma Fonts
- [ ] NextCloud
- [ ] Ansible
- [ ] Pulse
- [ ] Droidcam
- [X] Xclip
- [ ] Adapta theme
- [ ] Breeze Dark icons
- [ ] Breeze light cursor
- [ ] fzf
- [ ] hplip
- [ ] 
- [ ] Provide remove & cleanup tasks for every installed module/app.

- [ ] Remove i3status

- [ ] Enable same Nvim configurations for the Root user
- [ ] Add `fs.inotify.max_user_watches=524288` to `/etc/sysctl.conf`. https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
- [ ] Fonts are not loaded from ~/.fonts directory (Figma)
- [ ] Displays are not loaded correctly at i3 startup (how to set up primary screen)
- [ ] Keyboard switch does not work

`systemctl status named-chroot dhcpd tftp haproxy matchbox firewalld`

`ps cax | grep -E "named-chroot|dhcpd|tftp" > /dev/null`
