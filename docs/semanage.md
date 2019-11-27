# SEmanage

```sh
sudo sestatus
sudo semanage port -l
sudo semanage port -l | grep -w http_port_t
```

```sh
sudo semanage port -a -t http_port_t -p tcp 22623
sudo semanage port -a -t http_port_t -p tcp 6443
```
