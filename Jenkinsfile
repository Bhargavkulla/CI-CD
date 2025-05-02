pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = 'docker_credentials'  // Set your Docker credentials ID
        REGISTRY_URL = 'https://hub.docker.com/r/bhargavakulla/java-microservice'
        REGISTRY_CREDENTIALS = 'bhargavakulla/******'  // Set your Docker registry credentials
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Setup Python') {
            steps {
                script {
                    // Update and install required packages
                    sh 'sudo apt-get update'
                    sh 'sudo apt-get install -y python3 python3-pip'

                    // Install dependencies globally using pip
                    sh 'sudo pip3 install -r requirements.txt'  // Install globally to avoid missing pytest
                }
            }
        }

        stage('Test with Pytest') {
            steps {
                script {
                    // Verify pytest installation
                    sh 'pip show pytest'  // Debug step to ensure pytest is installed
                    // Run the tests
                    sh 'pytest tests/'
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t ${REGISTRY_URL}:latest .'
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Push Docker image to Docker Hub
                    sh 'docker login -u ${REGISTRY_CREDENTIALS} -p ${DOCKER_CREDENTIALS}'
                    sh 'docker push ${REGISTRY_URL}:latest'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deployment commands (ensure kubectl is configured)
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }

        stage('Post Actions') {
            steps {
                cleanWs()  // Clean workspace after build
            }
        }
    }
}
