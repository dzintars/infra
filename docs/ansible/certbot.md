# Certbot

Nice YouTube video on how to create wildcard TLS certificates [link](https://www.youtube.com/watch?v=3D4-MWG1Bew)

```sh
sudo certbot --manual certonly --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory -d example.com -d *.example.com -d *.ocp.example.com -d *.apps.ocp.example.com -d *.api.ocp.example.com
```

```sh
sudo certbot --manual certonly --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory -d example.com -d *.example.com
```

> If use ZSH place backslash before wildcard - [issue](https://github.com/ohmyzsh/ohmyzsh/issues/31#issuecomment-83031)

To check does your new TXT record was propogted accross DNS use this command:

```sh
host -t txt _acme-challenge.example.com
```

or you can use [MX Toolbox service](https://mxtoolbox.com/SuperTool.aspx)

Booth solutions should return your TXT value.

IMPORTANT NOTES:

- Congratulations! Your certificate and chain have been saved at:
  /etc/letsencrypt/live/example.com/fullchain.pem
  Your key file has been saved at:
  /etc/letsencrypt/live/example.com/privkey.pem
  Your cert will expire on 2020-01-19. To obtain a new or tweaked
  version of this certificate in the future, simply run certbot
  again. To non-interactively renew _all_ of your certificates, run
  "certbot renew"
- If you like Certbot, please consider supporting our work by:

  Donating to ISRG / Let's Encrypt: https://letsencrypt.org/donate
  Donating to EFF: https://eff.org/donate-le

/home/dzintars/letsencrypt

```sh
sudo ls -lah /etc/letsencrypt/live/example.com

lrwxrwxrwx. 1 root root   33 Mar 15 23:21 cert.pem -> ../../archive/example.com/cert1.pem             ca.pem
lrwxrwxrwx. 1 root root   34 Mar 15 23:21 chain.pem -> ../../archive/example.com/chain1.pem
lrwxrwxrwx. 1 root root   38 Mar 15 23:21 fullchain.pem -> ../../archive/example.com/fullchain1.pem   server.crt
lrwxrwxrwx. 1 root root   36 Mar 15 23:21 privkey.pem -> ../../archive/example.com/privkey1.pem       server.key
```

[Concancanate certificates with private key](https://serversforhackers.com/c/letsencrypt-with-haproxy)

```sh
sudo cat /etc/letsencrypt/live/example.com/fullchain.pem \
    /etc/letsencrypt/live/example.com/privkey.pem \
    | sudo tee ~/.tls/example.com/example.com.pem
```
