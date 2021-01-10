[Requesting and installing Let’s Encrypt Certificates for OpenShift 4](https://github.com/redhat-cop/openshift-lab-origin/blob/master/OpenShift4/Lets_Encrypt_Certificates_for_OCP4.adoc)

= Requesting and installing Let's Encrypt Certificates for OpenShift 4

== Overview

For any OpenShift cluster it is suggested to use proper certificates to secure the routes and API endpoints.

In OpenShift 3 certificates are usually added during the installation process by modifying the `/etc/ansible/hosts` file. In OpenShift 4 however there is no mechanism to provide certificates during the installation process. Adding certificates is considered a post-installation task.

Luckily in OpenShift 4 it is very easy to apply certificates after the installation has completed.

This document walks through using *Let's Encrypt* to provision certificates for your cluster. You will need to know the API endpoint URL and the Wildcard Domain for your router(s).

== Installing acme.sh

If you already have certificates for your domains you may skip this step and go straight to <<installing>>.

In order to request Let's Encrypt certificates we will use the *acme.sh* client. This client makes it very easy to request and update certificates.

. Clone the `acme.sh` GitHub repository.
+
[source,sh]
----
cd $HOME
git clone https://github.com/neilpang/acme.sh
cd acme.sh
----

. Update the file `$HOME/acme.sh/dnsapi/dns_aws.sh` with your AWS access credentials. This is necessary because you are requesting a certificate for wildcard domain and Let's Encrypt needs a way to validate that you are the owner of the wildcard domain.
+
Open the file in your favorite text editor and then add your AWS credentials. You will also need to remove the comment (`#`) before these two lines. The top of the file should look like this:
+
[source,sh]
----
#!/usr/bin/env sh

#
AWS_ACCESS_KEY_ID="YOUR ACCESS KEY"
#
AWS_SECRET_ACCESS_KEY="YOUR SECRET ACCESS KEY"

#This is the Amazon Route53 api wrapper for acme.sh

[...]
----

== Requesting Certificates

. To make things a bit easier set two environment variables. The first variable should point to your API Endpoint. Make sure you are logged into OpenShift as `system:admin` and use the `oc` CLI to find the API Endpoint URL.
+
[source,sh]
----
oc whoami --show-server
----
+
.Sample Output
[source,texinfo]
----
https://cluster-e954-api.e954.ocp4.opentlc.com:6443
----

. Now set the variable LE_API to the fully qualified domain name:
+
[source,sh]
----
export LE_API=$(oc whoami --show-server | cut -f 2 -d ':' | cut -f 3 -d '/' | sed 's/-api././')
----

. Set the second variable LE_WILDCARD to your Wildcard Domain for example:
+
[source,sh]
----
export LE_WILDCARD=$(oc get ingresscontroller default -n openshift-ingress-operator -o jsonpath='{.status.domain}')
----

. Run the acme.sh script
+
[source,sh]
----
${HOME}/acme.sh/acme.sh --issue -d ${LE_API} -d *.${LE_WILDCARD} --dns dns_aws
----

. It is usually a good idea to move the certificates from the `acme.sh` default path to a well known directory. So use the `--install-cert` option of the `acme.sh` script to copy the certificates to `$HOME/certificates`.

+
[source,sh]
----
export CERTDIR=$HOME/certificates
mkdir -p ${CERTDIR}
${HOME}/acme.sh/acme.sh --install-cert -d ${LE_API} -d *.${LE_WILDCARD} --cert-file ${CERTDIR}/cert.pem --key-file ${CERTDIR}/privkey.pem --fullchain-file ${CERTDIR}/fullchain.pem --ca-file ${CERTDIR}/ca.cer
----

[[installing]]
== Installing Certificates for Ingress Controllers

The following instructions work for OpenShift 4.1.0 and higher.

The ingress controllers expect the certificates in a `Secret`. This secret needs to be created in the project `openshift-ingress`.

. Use the following command to create the secret - and if you have existing certificates make sure to provide the path to your certificates instead.
+
[source,sh]
----
oc create secret tls ingress-certs --cert=${CERTDIR}/fullchain.pem --key=${CERTDIR}/privkey.pem -n openshift-ingress
----

. Now update the Custom Resource for your ingress controllers. The default custom resource is of type `IngressController`, is named `default` and is located in the `openshift-ingress-operator` project. Note that this project is different from where you created the secret earlier.
+
[source,sh]
----
oc patch ingresscontroller default -n openshift-ingress-operator --type=merge --patch='{"spec": { "defaultCertificate": { "name": "ingress-certs" }}}'
----

. This is all you need to do for ingress controllers. After you update the IngressController object the OpenShift ingress operator notices that the custom resource has changed and therefore re-deploys the ingress controllers in the openshift-ingress namespace.

== Installing Certificates for the API

The API uses another secret to secure the API Endpoint. This secret needs to be created in the project `openshift-config`.

. Use the following command to create the secret - and if you have existing certificates make sure to provide the path to your certificates instead.
+
[source,sh]
----
oc create secret tls api-certs --cert=${CERTDIR}/fullchain.pem --key=${CERTDIR}/privkey.pem -n openshift-config
----

. Now update the Custom Resource for your API server. The default custom resource is of type `APIServer`, is named `clustter` and is a cluster-wide resource.
+
[source,sh]
----
oc patch apiserver cluster --type=merge --patch='{"spec": {"servingCerts": {"namedCertificates": [{"names": [" '$LE_API' "], "servingCertificate": {"name": "api-certs"}}]}}}'
----

.  After you update the ApiServer object the OpenShift kube-apiserver notices that the custom resource has changed and therefore re-deploys the api servers in the kube-apiserver namespace.
+
This process can take a few minutes. You can watch the clusteroperators. When all cluster operators show Available as True and Progressing as False everything has been updated successfully.
+
[source,sh]
----
oc get clusteroperators
----
+
[source,sh]
----
NAME                                 VERSION   AVAILABLE   PROGRESSING   DEGRADED   SINCE
authentication                       4.1.6     True        False         False      19d
[...]
kube-apiserver                       4.1.6     True        True          False      19d
[...]
----

. When the API certificates have been deployed to all API Servers you will see errors that your client certificate is no longer valid. To fix this you will need to edit all your kube config files and remove every line starting with `certificate-authority-data:`. The following Ansible playbook will find all config files and delete that line:
+
[source,yaml]
----
- name: Fix all Kube Configs
  hosts: localhost
  become: no
  tasks:
  - name: Find all Kube Configs
    become: yes
    find:
      file_type: file
      hidden: true
      paths:
      - /root
      - /home
      contains: "^ +certificate-authority-data:"
      patterns: "*config*"
      recurse: yes
    register: r_config_files

  - name: Fix Kube Configs
    become: yes
    replace:
      path: "{{ item.path }}"
      regexp: "^ +certificate-authority-data:"
    loop: "{{r_config_files.files}}"
----
+
You can save this playbook to a file (e.g. `fix-kube-configs.yaml`) and then run it using `ansible-playbook fix-kube-configs.yaml`.

. You now have proper certificates for your entire OpenShift cluster - and this includes custom applications, the Web Console for your OpenShift Cluster and the API Endpoint.