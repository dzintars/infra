# Configuring TLS

```sh
sudo certbot --manual certonly --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory -d example.com -d *.example.com -d *.ocp.example.com -d *.apps.ocp.example.com -d *.api.ocp.example.com
```

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
sudo openssl s_server -accept 8888 -WWW -cert /etc/letsencrypt/live/example.com/fullchain.pem -key /etc/letsencrypt/live/example.com/privkey.pem
```

[configuring-certificates](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.2/html-single/authentication/index#configuring-certificates)

[Merge pull request #26 from RedHat-EMEA-SSA-Team/post-install](https://github.com/RedHat-EMEA-SSA-Team/hetzner-ocp4/commit/f8f57c734b5c593a85cd6d60a34708bba5110d2b)

```sh
oc create secret tls letsencrypt-ingress-certs \
    --cert=/home/dzintars/letsencrypt/fullchain.pem \
    --key=/home/dzintars/letsencrypt/privkey.pem \
    -n openshift-ingress
```

```sh
oc patch ingresscontroller.operator default \
    --type=merge -p \
    '{"spec":{"defaultCertificate": {"name": "letsencrypt-ingress-certs"}}}' \
    -n openshift-ingress-operator
```

```sh
oc create secret tls letsencrypt-api-certs \
     --cert=/home/dzintars/letsencrypt/fullchain.pem \
     --key=/home/dzintars/letsencrypt/privkey.pem \
     -n openshift-config
```

```sh
oc patch apiserver cluster \
     --type=merge -p \
     '{"spec":{"servingCerts": {"namedCertificates": [{"names": ["api.ocp.example.com"], "servingCertificate": {"name": "letsencrypt-api-certs"}}]}}}'
```

```sh
oc get apiserver cluster -o yaml
```

modules/customize-certificates-api-add-named.adoc

https://github.com/redhat-cop/openshift-lab-origin/blob/master/OpenShift4/Lets_Encrypt_Certificates_for_OCP4.adoc

```sh
oc create secret tls letsencrypt-ingress-certs --cert=${CERTDIR}/fullchain.pem --key=${CERTDIR}/privkey.pem -n openshift-ingress
oc patch ingresscontroller default -n openshift-ingress-operator --type=merge --patch='{"spec": { "defaultCertificate": { "name": "letsencrypt-ingress-certs" }}}'
```

```sh
oc create secret tls letsencrypt-api-certs --cert=/etc/letsencrypt/live/example.com/fullchain.pem --key=/etc/letsencrypt/live/example.com/privkey.pem -n openshift-config
oc patch apiserver cluster --type=merge --patch='{"spec": {"servingCerts": {"namedCertificates": [{"names": ["api.ocp.example.com"], "servingCertificate": {"name": "letsencrypt-api-certs"}}]}}}'
```

After this OC CLI will not be able to connect to cluster.

```sh
error: you must use a client config with a token
```

So you should modify \$HOME/.kube/config file to look like this:

```yaml
apiVersion: v1
clusters:
  - cluster:
      insecure-skip-tls-verify: true
      server: https://api.ocp.example.com:6443
    name: api-ocp-example-com:6443
contexts:
  - context:
      cluster: api-ocp-example-com:6443
      namespace: openshift-ingress-operator
      user: kube:admin/api-ocp-example-com:6443
    name: openshift-ingress-operator/api-ocp-example-com:6443/kube:admin
current-context: openshift-ingress-operator/api-ocp-example-com:6443/kube:admin
kind: Config
preferences: {}
users:
  - name: kube:admin/api-ocp-example-com:6443
    user:
      token: Jxy92b-Wiu7W4YjyB6fTsz0A_Qx9USKJco0c3aOSI50
```

https://blog.openshift.com/lets-encrypt-acme-v2-api/
https://redhatnordicssa.github.io/ansible-letsencrypt-openshift
