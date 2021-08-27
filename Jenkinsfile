pipeline {
    agent {
        docker {
            image 'hashicorp/terraform:latest'
            args  '--entrypoint=""'
        }
    }
    options {
        disableConcurrentBuilds()
    }
    stages {
     stage('Terraform Init'){
            
            steps {
                    ansiColor('xterm') {
                    withCredentials([azureServicePrincipal(
                    credentialsId: 'terraform-svc',
                    subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                    clientIdVariable: 'ARM_CLIENT_ID',
                    clientSecretVariable: 'ARM_CLIENT_SECRET',
                    tenantIdVariable: 'ARM_TENANT_ID'
                ), string(credentialsId: 'access_key', variable: 'ARM_ACCESS_KEY')]) {
     
                 
                        sh """
                                
                        echo "Initialising Terraform"
                        sh scripts/terraform.sh plan
                        """
                           }
                    }
             }
        }
        stage('Terraform Apply') {
		
            when {
				 expression {env.GIT_BRANCH == 'origin/release'}
			}
            steps {
                withCredentials([
                    azureServicePrincipal(
                        credentialsId:          'terraform-svc',
                        subscriptionIdVariable: 'ARM_SUBSCRIPTION_ID',
                        clientIdVariable:       'ARM_CLIENT_ID',
                        clientSecretVariable:   'ARM_CLIENT_SECRET',
                        tenantIdVariable:       'ARM_TENANT_ID'
                    )
                ])
                {
                    sh 'terraform init'
                    sh 'terraform apply'
                }
            }
        }
    }
}
