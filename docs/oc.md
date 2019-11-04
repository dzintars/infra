# OC CLI

To log into cluser use `oc login -u system:admin -n default`

##########################
#    oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"emptyDir":{}}}}'
##########################

```sh
openshift-install --dir=cluster wait-for install-complete --log-level debug
```