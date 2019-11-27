# Usefull commands

## Openshift Installer

```sh
curl -s https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-install-linux-4.2.0.tar.gz | tar -xzf - -C /usr/local/bin/ openshift-install

openshift-install --dir cluster create ignition-configs

openshift-install --dir=cluster wait-for bootstrap-complete --log-level=debug

oc patch configs.imageregistry.operator.openshift.io cluster --type merge --patch '{"spec":{"storage":{"emptyDir":{}}}}'

openshift-install --dir=ocp wait-for install-complete --log-level=debug
```

## OC CLI

```sh
# Get version of openshift-install
openshift-install version
# List all openshift nodes. `~/.kube/config` should be updated with latest `openshift-install/auth/kubeconfig`)
oc get nodes
oc get co
oc get co authentication -oyaml
oc get pods --all-namespaces | grep -i auth
oc logs authentication-operator-59bd6dffb8-r4phm -n openshift-authentication-operator

oc get event | grep OperatorStatusChanged

oc --config=cluster/auth/kubeconfig get clusterversion -oyaml
oc --config=cluster/auth/kubeconfig get clusteroperator authentication -o=jsonpath='{range .status.conditions[*]}{.type}{" "}{.status}{" "}{.message}{"\n"}{end}'
```

```sh
oc create secret generic github-oauth-secret --from-literal=clientSecret=6fbwer7fe0kjlk2dwfe98fw9efw9we90dba4c71b -n openshift-config
```