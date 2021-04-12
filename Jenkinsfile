pipeline {
    agent any
        triggers {
            // Trigger every 15 minutes
            pollSCM "*/15 * * * *"
        }

    stages {
        stage('Push Docker Image') {
            steps {
                echo 'Pushing HelloWorld Docker Image'
                script {
                    withAWS(credentials:'awsCredentials') {
                        invokeLambda([awsRegion: 'us-east-2',
                            functionName: 'lambda_deployment_trigger', 
                            payload: "{}", 
                            synchronous: true, 
                            useInstanceCredentials: true])
                        sh(script:
                        "aws lambda invoke --function-name lambda_deployment_trigger --region us-east-2 --payload '{}' /tmp/response.json")
                    }
                }
            }
        }
    }
}

