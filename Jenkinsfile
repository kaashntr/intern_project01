pipeline {
    agent any
    tools {
        jdk 'jdk11'
        gradle 'gradle-6.8.3'
    }
    stages {
        stage('Checkout CSM') {
            steps {
                checkout scm
            }
        }
        // stage('Build frontend') {
        //     steps {
        //         nodejs(nodeJSInstallationName: 'node14') {
        //             sh 'node -v'
        //             sh 'npm -v'
        //             dir("frontend/frontend"){
        //                 sh "npm install"
        //                 sh "npm run build"
        //             }
        //         }
        //     }
        // }
        stage('Deploy') {
            steps {
                echo "Deploy completed"
            }
        } 
        stage('Build backend'){
            steps{
                sh 'gradle --version'
            }
        }
    }
}