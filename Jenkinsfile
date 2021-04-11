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
    }
}