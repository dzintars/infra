# Video

What i did:

Swapped monitors in `nvidia-settings` by changing Configuration to X screen 0 and 1.
Set resolution from Auto to fixed max.
Edited `/etc/X11/xorg.conf` to look like Ansible nvidia role template. Removed any mentions of Xinerama.

Modified `~/.profile` to look like:

```sh
xrandr --output DVI-I-1 --auto --right-of DP-1.8 --auto --primary
feh --bg-fill ~/Pictures/Wallpapers/707709.jpg
PATH="$PATH:/usr/local/bin/go/bin"
```

Basically swapped monitors there, because otherwise i3wm was not recognizing 23" monitor.

Installed `sudo dnf install xorg-x11-drv-nvidia-cuda` and rebooted

Lost login screen and got black screen with blinking cursor.

ctrl+alt+f2

Followed instructions from [there](https://wiyogo.com/articles/2018/black-screen-issue-in-fedora-29-with-nvidia-gpu.html) and especially from [there](https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/2/).
This helped to fix login screen issue.

Installed vlc 3.0

`watch -n 0.5 nvidia-smi`
