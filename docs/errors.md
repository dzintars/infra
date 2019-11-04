# Error handling

## Console (Web UI) not working

Execute `oc get co` and you probably will see that `authentication` operator failed and so `console` is stuck as well.

```sh
oc get co
NAME                                       VERSION   AVAILABLE   PROGRESSING   DEGRADED   SINCE
authentication                                       Unknown     Unknown       True       12h
cloud-credential                           4.2.0     True        False         False      12h
cluster-autoscaler                         4.2.0     True        False         False      12h
console                                    4.2.0     False       True          False      12h
dns                                        4.2.0     True        False         False      12h
image-registry                             4.2.0     True        False         False      12h
ingress                                    4.2.0     True        False         False      12h
insights                                   4.2.0     True        False         False      12h
kube-apiserver                             4.2.0     True        False         False      12h
kube-controller-manager                    4.2.0     True        False         False      12h
kube-scheduler                             4.2.0     True        False         False      12h
machine-api                                4.2.0     True        False         False      12h
machine-config                             4.2.0     True        False         False      12h
marketplace                                4.2.0     True        False         False      12h
monitoring                                 4.2.0     True        False         False      12h
network                                    4.2.0     True        False         False      12h
node-tuning                                4.2.0     True        False         False      12h
openshift-apiserver                        4.2.0     True        False         False      12h
openshift-controller-manager               4.2.0     True        False         False      12h
openshift-samples                          4.2.0     True        False         False      12h
operator-lifecycle-manager                 4.2.0     True        False         False      12h
operator-lifecycle-manager-catalog         4.2.0     True        False         False      12h
operator-lifecycle-manager-packageserver   4.2.0     True        False         False      12h
service-ca                                 4.2.0     True        False         False      12h
service-catalog-apiserver                  4.2.0     True        False         False      12h
service-catalog-controller-manager         4.2.0     True        False         False      12h
storage                                    4.2.0     True        False         False      12h
```

To see more details execute `oc get pods --all-namespaces | grep -i auth`

```sh
oc get pods --all-namespaces | grep -i auth
openshift-authentication-operator             authentication-operator-59bd6dffb8-r4phm         1/1     Running       0          12h
openshift-authentication                      oauth-openshift-5577786f98-whtpc                 1/1     Running       0          12h
openshift-authentication                      oauth-openshift-5577786f98-xh7h7                 1/1     Running       0          12h
```

Then copy `authentication-operator-59bd6dffb8-r4phm` and place it this command:

```sh
oc logs authentication-operator-59bd6dffb8-r4phm -n openshift-authentication-operator
```

You will see authentication operator log.

I am interested in this error:

```sh
controller.go:129] {AuthenticationOperator2 AuthenticationOperator2} failed with: failed handling the route: route is not available at canonical host oauth-openshift.apps.ocp.example.com: []
```
There i found some bug reports to what seems to me similar issues:

https://bugzilla.redhat.com/show_bug.cgi?id=1744599

https://github.com/openshift/cluster-authentication-operator/issues/178

https://bugzilla.redhat.com/show_bug.cgi?id=1743353

https://bugzilla.redhat.com/show_bug.cgi?id=1740121



https://bugzilla.redhat.com/show_bug.cgi?id=1723445

https://bugzilla.redhat.com/show_bug.cgi?id=1712525

### Solution

It turns out, that you can't boot all nodes at once. First, you should boot Bootstrap, Master and Infra nodes. Only when bootstrap process is done, you can boot worker nodes.
In this scenario, i got authentication and console operator running and i can log in now into Console UI.

But now i have issue to boot Compute nodes. It seems they are looking for ignition configs at http://api-int.ocp.example.com:22623/config/worker but by some reason, there is nothing at that location. I need to check that.


## @ early bootstrap stage:

```sh
[***   ] A start job is running for Ignition (disks) (37min 33s / no limit)[ 2315.213418] ignition[574]: GET https://api-int.ocp.example.com:22623/config/master: attempt #455
[ 2315.215940] ignition[574]: GET error: Get https://api-int.ocp.example.com:22623/config/master: dial tcp 192.168.1.254:22623: connect: connection refused
```
I found this blog article:

https://www.techbeatly.com/2019/07/openshift-4-libvirt-upi-installation.html/

This lead me to some activity in master nodes. Haproxy semanage port section.

Ececute this commands on your Bastion

```sh
semanage port  -a 22623 -t http_port_t -p tcp
semanage port  -a 6443 -t http_port_t -p tcp
```

> CHECK does HAProxy was started properly. Sometimes it does not grab latest config. Not sure why.

Resolution for me was:
1) Check `/etc/resolv.conf` in Bastion
2) Check firewalld open ports
3) Check semanage ports (!!!)

## Some guest VMs does not reboot

When ignition process is happening, guest VMs does reboot, but some of them stuck to shut down.

To resolve this, check what permissions has all volumes (drives) of those.
They all should be `qemu:qemu`.

Resolved by adding `sudo: yes` in Ansible module.

## Guest VMs does not automatically boot second time

To boot hem, i should launch them mannually. Not a big deal, but would likt to solve this.
Currently i have no solution and it's low priority.




```sh
ping oauth-openshift.apps.ocp.example.com

PING oauth-openshift.apps.ocp.example.com (192.168.1.254) 56(84) bytes of data.
64 bytes from bastion.ocp.example.com (192.168.1.254): icmp_seq=1 ttl=64 time=0.098 ms
64 bytes from bastion.ocp.example.com (192.168.1.254): icmp_seq=2 ttl=64 time=0.169 ms

--- oauth-openshift.apps.ocp.example.com ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 2ms
rtt min/avg/max/mdev = 0.098/0.133/0.169/0.037 ms

------------

ping oauth-openshift.apps.ocp.example.com

PING oauth-openshift.apps.ocp.example.com (192.168.1.254) 56(84) bytes of data.
64 bytes from api.ocp.example.com (192.168.1.254): icmp_seq=1 ttl=64 time=0.106 ms
64 bytes from api.ocp.example.com (192.168.1.254): icmp_seq=2 ttl=64 time=0.113 ms

--- oauth-openshift.apps.ocp.example.com ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 29ms
rtt min/avg/max/mdev = 0.106/0.109/0.113/0.011 ms
```


## Not accessible
http://api-int.ocp.example.com:22623/config/worker