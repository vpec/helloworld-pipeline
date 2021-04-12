pipeline {
    agent any
        triggers {
            // Trigger every 15 minutes
            pollSCM "*/15 * * * *"
        }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'cd helloworld-rest && ./gradlew build --no-daemon'
                sh 'ls helloworld-rest/build/libs'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'cd helloworld-rest && ./gradlew test --no-daemon'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'develop'
            }
            steps {
                echo 'Building HelloWorld Docker Image'
                dir('helloworld-rest') {
                    script {
                        app = docker.build("vpec1/helloworld-rest-app")
                    }
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'develop'
            }
            steps {
                echo 'Pushing HelloWorld Docker Image'
                script {
                    GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
                    SHORT_COMMIT = "${GIT_COMMIT_HASH[0..7]}"
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerHubCredentials') {
                        app.push("$SHORT_COMMIT")
                        app.push("latest")
                    }
                    //aws lambda invoke --function-name demo-function --region us-east-2 --payload '{}' response
                    sh(script:
                        "aws lambda invoke --function-name demo-function --region us-east-2 --payload '{}' /tmp/response.json")
                }
            }
        }
        stage('Remove local images') {
            when {
                branch 'develop'
            }
            steps {
                echo 'Delete the local docker images'
                sh("docker rmi -f vpec1/helloworld-rest-app:latest || :")
                sh("docker rmi -f vpec1/helloworld-rest-app:$SHORT_COMMIT || :")
            }
        }
    }
}

