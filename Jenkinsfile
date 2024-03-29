pipeline {
    /*
     * Note: This pipeline does not use any nodes for executing stages.
     * This was tested on a single EC2 instance with limited resources.
     * In a production environment, every pipeline workload should be
     * executed from within a node.
     */
    agent any
        triggers {
            // Trigger every 15 minutes
            pollSCM "*/15 * * * *"
        }

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'cd helloworld-rest && ./gradlew build --no-daemon'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'cd helloworld-rest && ./gradlew test --no-daemon'
            }
        }
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploying...'
                echo 'Building HelloWorld Docker Image'
                dir('helloworld-rest') {
                    script {
                        app = docker.build("vpec1/helloworld-rest-app")
                    }
                }
                echo 'Pushing HelloWorld Docker Image'
                script {
                    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
                    SHORT_COMMIT = "${GIT_COMMIT_HASH[0..7]}"
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerHubCredentials') {
                        app.push("$SHORT_COMMIT")
                        app.push("latest")
                    }
                }
                echo 'Trigger lambda deployment function'
                script {
                    withAWS(credentials:'awsCredentials') {
                        invokeLambda([awsRegion: 'us-east-2',
                            functionName: 'lambda_deployment_trigger', 
                            synchronous: true, 
                            useInstanceCredentials: true,
                            returnValueAsString: true])
                    }
                }
                echo 'Delete the local docker images'
                sh("docker rmi -f vpec1/helloworld-rest-app:latest || :")
                sh("docker rmi -f vpec1/helloworld-rest-app:$SHORT_COMMIT || :")
            }
        }
    }
}

