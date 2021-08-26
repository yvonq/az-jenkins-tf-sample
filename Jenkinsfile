pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:0.12.31'
        }
    }

    stages {
        stage('Terraform Plan') {
			when {
                branch 'main'
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
                    sh 'sh scripts/terraform.sh plan'
                }
            }
        }
        stage('Terraform Apply') {
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
                    sh 'sh scripts/terraform.sh apply'
                }
            }
        }
    }
}
