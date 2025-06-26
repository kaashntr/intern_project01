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
            environment {
                // Ensure 'docker-hub-pat-credentials' is configured in Jenkins Credentials Manager
                // as 'Username with password', where Username is 'kaashntr' and Password is your PAT.
                DOCKER_HUB_CREDENTIALS_ID = 'docker-hub-pat-credentials'
                DOCKER_HUB_USERNAME = 'kaashntr' // Your Docker Hub username
                APP_NAME = 'hell_is_full'
                // This creates a tag like "BUILD_NUMBER-SHORT_GIT_COMMIT_HASH" or "BUILD_NUMBER-latest"
                IMAGE_TAG_VERSION = "${env.BUILD_NUMBER}-${env.GIT_COMMIT?.substring(0, 7) ?: 'latest'}"
                // The full name including your Docker Hub username/org
                FULL_IMAGE_NAME = "${DOCKER_HUB_USERNAME}/${APP_NAME}"
                DOCKER_REGISTRY_URL = 'docker.io' 
            }
            steps {
                // Optional: Verify Docker is accessible and its version
                sh 'docker --version'

                script { // 'script' block is needed to use withCredentials inside 'steps'
                    // Use withCredentials to securely expose the Docker Hub username and PAT
                    // as environment variables within this block.
                    dir("backend"){
                        withCredentials([usernamePassword(credentialsId: env.DOCKER_HUB_CREDENTIALS_ID, passwordVariable: 'DOCKER_PAT', usernameVariable: 'DOCKER_USER')]) {
                            // 1. Login to Docker Hub or your private registry
                            // Using -u and -p as requested.
                            // The ${DOCKER_REGISTRY_URL} is included for clarity,
                            // but for Docker Hub, 'docker login -u ... -p ...' works fine without the URL.
                            sh "docker login ${DOCKER_REGISTRY_URL} -u ${DOCKER_USER} -p ${DOCKER_PAT}"

                            // 2. Build the Docker Image
                            // The '.' means the build context is the current working directory (Jenkins workspace).
                            // Docker will look for a Dockerfile in this directory.
                            // We apply two tags: the dynamic version tag and 'latest'.
                            sh "docker build -t ${FULL_IMAGE_NAME}:${IMAGE_TAG_VERSION} -t ${FULL_IMAGE_NAME}:latest ."

                            // 3. Push the Docker Image(s) to Docker Hub or your private registry
                            echo "Pushing image ${FULL_IMAGE_NAME}:${IMAGE_TAG_VERSION}..."
                            sh "docker push ${FULL_IMAGE_NAME}:${IMAGE_TAG_VERSION}"

                            echo "Pushing image ${FULL_IMAGE_NAME}:latest..."
                            sh "docker push ${FULL_IMAGE_NAME}:latest"

                            // 4. Logout from Docker Hub or your private registry (good practice for security)
                            sh "docker logout ${DOCKER_REGISTRY_URL}"
                        }
                    }
                }
            }
        }
    }
}