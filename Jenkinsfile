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
                nodejs(nodeJSInstallationName: 'Node.js 14.x LTS') {
                    sh 'node -v'
                    sh 'npm -v'
                    // sh 'npm install' // Install project dependencies
                    // sh 'npm run build' // Build your frontend application
                }
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploy completed"
            }
        }
    }
}