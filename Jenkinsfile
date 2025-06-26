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
                dir("backend/backend"){
                    sh "gradle clean war"
                }
            }
        }
        stage('Build Docker Image') {
            // This stage will run on an agent labeled 'docker-host'
            // or directly use a 'docker' agent type
            // agent {
            //     label 'docker-agent' // Agent specifically configured with Docker daemon access
            // }
            environment {
                DOCKER_HUB_CREDENTIALS_ID = 'docker-hub-pat-credentials'
                DOCKER_HUB_USERNAME = 'kaashntr'
                APP_NAME = 'hell_is_full'
                IMAGE_TAG_VERSION = "${env.BUILD_NUMBER}-${env.GIT_COMMIT?.substring(0, 7) ?: 'latest'}"
                FULL_IMAGE_NAME = "${DOCKER_HUB_USERNAME}/${APP_NAME}"
            }
            steps {
                // script {
                //     def builtImage = docker.build "${FULL_IMAGE_NAME}:${IMAGE_TAG_VERSION}", '.'
                //     builtImage.addTag('latest')
                //     docker.withRegistry("https://index.docker.io/v1/", DOCKER_HUB_CREDENTIALS_ID) {
                //         builtImage.push()
                //         builtImage.push('latest')
                //     }
                // }
                sh 'docker --version'
            }
        }
    }
}