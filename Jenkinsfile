pipeline {
    agent any
    stages {
        stage('Checkout CSM') {
            steps {
                checkout scm
            }
        }
        stage('Build frontend') {
            steps {
                sh """
                    ls -la
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