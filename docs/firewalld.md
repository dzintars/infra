# FirewallD

```sh
sudo firewall-cmd --permanent --add-service dhcp
sudo firewall-cmd --reload
```

```sh
sudo firewall-cmd --permanent --remove-port 67/udp
```

If you’ve got several network interfaces in IPv4, you will have to activate ip forwarding.
To do that, paste the following line into the /etc/sysctl.conf file: `net.ipv4.ip_forward=1`
