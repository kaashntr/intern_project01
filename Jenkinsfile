pipeline {
    agent any
    stages {
        stage('Checkout CSM') {
            steps {
                checkout scm
            }
        }
        stage('Build frontend') {
            agent {
                docker{
                    image "node:14-alpine"
                }     
            }
            steps {
                sh """
                    node -v
                """
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploy completed"
            }
        }
    }
}