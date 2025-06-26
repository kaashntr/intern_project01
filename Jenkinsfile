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
            environment {
                DOCKER_HUB_CREDENTIALS_ID = 'docker-hub-pat-credentials'
                DOCKER_HUB_USERNAME = 'kaashntr' // Your Docker Hub username
                APP_NAME = 'hell_is_full'
                IMAGE_TAG_VERSION = "${env.BUILD_NUMBER}-${env.GIT_COMMIT?.substring(0, 7) ?: 'latest'}"
                FULL_IMAGE_NAME = "${DOCKER_HUB_USERNAME}/${APP_NAME}"
                DOCKER_REGISTRY_URL = 'docker.io' 
            }
            steps {
                sh 'docker --version'
                script { 
                    dir("backend"){
                        withCredentials([usernamePassword(credentialsId: env.DOCKER_HUB_CREDENTIALS_ID, passwordVariable: 'DOCKER_PAT', usernameVariable: 'DOCKER_USER')]) {
                            sh "docker login ${DOCKER_REGISTRY_URL} -u ${DOCKER_USER} -p ${DOCKER_PAT}"
                            sh "docker build -t ${FULL_IMAGE_NAME}:${IMAGE_TAG_VERSION} -t ${FULL_IMAGE_NAME}:latest ."
                            echo "Pushing image ${FULL_IMAGE_NAME}:${IMAGE_TAG_VERSION}..."
                            sh "docker push ${FULL_IMAGE_NAME}:${IMAGE_TAG_VERSION}"
                            echo "Pushing image ${FULL_IMAGE_NAME}:latest..."
                            sh "docker push ${FULL_IMAGE_NAME}:latest"
                            sh "docker logout ${DOCKER_REGISTRY_URL}"
                        }
                    }
                }
            }
        }
    }
}