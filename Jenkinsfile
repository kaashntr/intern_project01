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
                nodejs(nodeJSInstallationName: 'node14') {
                    sh 'node -v'
                    sh 'npm -v'
                    dir("frontend/frontend"){
                        sh "npm install"
                        sh "npm run build"
                    }
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