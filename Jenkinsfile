pipeline {
    agent any
    stages {
        stage('Build frontend') {
            steps {
                echo "Build completed"
                checkout scm
            }
        }
        stage('Test') {
            steps {
                echo "Test completed"
                sh "ls -la"
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploy completed"
            }
        }
    }
}