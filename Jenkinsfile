pipeline {
    agent any
        triggers {
            // Trigger every 15 minutes
            pollSCM "*/15 * * * *"
        }

    stages {
        stage('Push Docker Image') {
            when {
                branch 'develop'
            }
            steps {
                echo 'Pushing HelloWorld Docker Image'
                script {
                    //aws lambda invoke --function-name lambda_deployment_trigger --region us-east-2 --payload '{}' response
                    sh(script:
                        "aws lambda invoke --function-name lambda_deployment_trigger --region us-east-2 --payload '{}' /tmp/response.json")
                }
            }
        }
    }
}

