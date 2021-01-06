pipeline {
  agent any
  environment {
    TF_WORKSPACE = 'dev' //Sets the Terraform Workspace
    TF_IN_AUTOMATION = 'true'
    MINIO_ACCESS_KEY="minio"
    MINIO_SECRET_KEY="miniostorage"
    BUCKET="terraform"
  }
  stages {
    stage('1 Terraform Init') {
      steps {
        sh "${env.TERRAFORM_HOME}/terraform init -input=false"
      }
    }
    stage('2 Terraform Plan') {
      steps {
        sh "${env.TERRAFORM_HOME}/terraform plan -out=tfplan -input=false -var-file='terraform/env/dev/terraform.tfvars'"
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
