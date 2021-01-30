Sign In into your GitLab account
Go to Settings -> Applications
Enter Name like "OpenShift" to identify your cluster
Enter Redirect URI: `https://oauth-openshift.apps.ocp.example.com/oauth2callback/GitLab`

> `gitlab` section is Case Sensitive! If you want to name your identity provider "GitLab", then you should type it there as well `GitLab`

In new browser tab go to your OpenShift console UI
Sign In using kube:admin
Go to Administration -> Cluster Settings -> Global Configuration -> OAuth
You should see a list of Identity Providers which should be empty.
Press Add and choose GitLab
Type a name of your provider like `GitLab` as example. Be aware that this name should match with name used Redirect URI and it is Case Sensitive. [Documentation](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.1/html/authentication/configuring-identity-providers#identity-provider-gitlab-CR_configuring-gitlab-identity-provider)
Enter URL `https://gitlab.com`
Copy Application ID from GitLab's page you left previously
Paste Application ID into OpenShift's Client ID field
Copy Secret from GitLab's page
Paste Secret into Client Secret field
Leave CA File field empty as it is optional (Certbot's chain.pem)
Press Add
Wait a minute or few
Sign Out from OpenShift Console UI
You should see now "GitLab" Sign In option

```sh
cat ~/.acme.sh/yourdomain/yourdomain.cer ~/.acme.sh/yourdomain/yourdomain.key ~/.acme.sh/yourdomain/ca.cer > /tmp/cloudapps.router.pem
```
```sh
cat /home/dzintars/letsencrypt/fullchain.pem /home/dzintars/letsencrypt/privkey.pem /home/dzintars/letsencrypt/chain.pem > /tmp/cloudapps.router.pem
```
```sh
oc secrets new router-certs tls.crt=/tmp/cloudapps.router.pem tls.key=/home/dzintars/letsencrypt/privkey.pem -o json --type='kubernetes.io/tls' --confirm | oc replace -f -
```