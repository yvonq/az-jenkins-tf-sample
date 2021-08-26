pipeline {
    agent none
    options {
        disableConcurrentBuilds()
    }

    stages {
        stage('Terraform Plan') {
		agent {
        docker {
		        image 'hashicorp/terraform:latest'
                label 'LINUX-SLAVE'
                args  '--entrypoint=""'
				}
		}
			options {
        ansiColor('xterm')
    }
            steps {
                withCredentials([
                    azureServicePrincipal(
                        credentialsId:          'terraform-svc',
                        subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                        clientIdVariable:       'ARM_CLIENT_ID',
                        clientSecretVariable:   'ARM_CLIENT_SECRET',
                        tenantIdVariable:       'ARM_TENANT_ID'
                    ),
                  string(credentialsId: 'terraform-svc', variable: 'access_key')
                ])
                {
                    sh 'terraform version'
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Apply') {
		agent {
        docker {
		        image 'hashicorp/terraform:0.12.31' 
		        args '--entrypoint='
				}
		}
            when {
                branch 'release'
            }
            steps {
                withCredentials([
                    azureServicePrincipal(
                        credentialsId:          'terraform-svc',
                        subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                        clientIdVariable:       'ARM_CLIENT_ID',
                        clientSecretVariable:   'ARM_CLIENT_SECRET',
                        tenantIdVariable:       'ARM_TENANT_ID'
                    ),
                  string(credentialsId: 'terraform-svc', variable: 'access_key')
                ])
                {
                    sh 'terraform init'
                    sh 'terraform apply'
                }
            }
        }
    }
}
