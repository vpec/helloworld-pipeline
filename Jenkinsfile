pipeline {
    agent any

    stages {
        stage('Clean') {
            steps {
                echo 'Cleaning..'
                script {
                    try {
                        sh 'rm -r helloworld-pipeline'
                        echo 'Previous repo clone deleted'
                    }
                    catch (exc) {
                        echo 'No previous repo clone was found'
                    }
                }
            }
        }
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'git clone https://github.com/vpec/helloworld-pipeline.git'
                sh 'ls -la'
                sh 'cd helloworld-pipeline && git checkout develop'
                sh 'cd helloworld-pipeline && git branch'
                sh 'cd helloworld-pipeline/helloworld-rest && ./gradlew build --no-daemon'
                sh 'ls helloworld-pipeline/helloworld-rest/build/libs'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'cd helloworld-pipeline/helloworld-rest && ./gradlew test --no-daemon'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}