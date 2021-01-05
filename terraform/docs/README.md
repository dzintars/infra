# Terraform

In order to initialize this project first you need to set some envirionment variables.
Replace the keys with the real values.

`export MINIO_ACCESS_KEY="minio"`
`export MINIO_SECRET_KEY="miniostorage"`
`export BUCKET="terraform"`

Then you can initialize this project

`terraform init -backend-config="access_key=$MINIO_ACCESS_KEY" -backend-config="secret_key=$MINIO_SECRET_KEY" -backend-config="bucket=$BUCKET"`
