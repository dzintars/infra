# How To debug

[GitHub issue: How to debug](https://github.com/openshift/cluster-authentication-operator/issues/131)

```sh
openshift-install gather bootstrap --dir=ocp --bootstrap 192.168.1.253 --master "192.168.1.10 192.168.1.11 192.168.1.12"
ssh -A core@bootstrap-0.ocp.example.com '/usr/local/bin/installer-gather.sh 192.168.1.10 192.168.1.11 192.168.1.12'
```

If you have issues to get bootstrap process done, then you can ssh into your bootstrap node `ssh core@bootstrap-0.ocp.example.com` and to run `journalctl -b -f -u bootkube.service`. It will output bootstrap logs.
Be sure you clear your ssh known_hosts `vim ~/.ssh/known_hosts` and delete (`shift+v` and `delete` and `:wq!`) bootstrap's IP or host records.

In my opinion most common issues with bootstrap process could be related to DNS.