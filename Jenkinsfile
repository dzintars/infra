pipeline {
  agent any
  environment {
    TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
    TERRAFORM_HOME = tool name: 'terraform-0.14.3', type: 'terraform'
    MINIO_ACCESS_KEY="minio"
    MINIO_SECRET_KEY="miniostorage"
    BUCKET="terraform"
  }
  stages {
    stage('1 Terraform Init') {
      steps {
        dir('./terraform/env/dev') {
          sh "${env.TERRAFORM_HOME}/terraform --version"
          /* sh "${env.TERRAFORM_HOME}/terraform init -input=false" */
          sh '${env.TERRAFORM_HOME}/terraform init -backend-config="access_key=&{env.MINIO_ACCESS_KEY}" -backend-config="secret_key=${env.MINIO_SECRET_KEY}" -backend-config="bucket=${env.BUCKET}" -input=false'
        }
      }
    }
    stage('2 Terraform Plan') {
      steps {
        sh "cd ./terraform/env/dev && ${env.TERRAFORM_HOME}/terraform plan -out=tfplan -input=false -var-file='terraform/env/dev/terraform.tfvars'"
      }
    }
    stage('3 Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "${env.TERRAFORM_HOME}/terraform apply -input=false tfplan"
      }
    }
  }
}
