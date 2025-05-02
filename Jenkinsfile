pipeline {
    agent any

    environment {
        // Define Docker registry credentials
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_IMAGE = 'bhargavakulla/java-microservice'
        DOCKER_CREDENTIALS = 'docker_credentials'
        GITHUB_CREDENTIALS = 'github-credentials'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Setup Python') {
            steps {
                // Install Python and pip (if not already installed)
                sh 'sudo apt-get update'
                sh 'sudo apt-get install -y python3 python3-pip'
            }
        }

        stage('Test with Pytest') {
            steps {
                script {
                    // Install dependencies from requirements.txt
                    sh 'pip install -r requirements.txt'
                    
                    // Run the pytest command
                    sh 'pytest tests/'
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t ${DOCKER_IMAGE} .'
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Log in to Docker registry
                    docker.withRegistry("https://${DOCKER_REGISTRY}", DOCKER_CREDENTIALS) {
                        // Push the image to Docker registry
                        sh 'docker push ${DOCKER_IMAGE}'
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy to Kubernetes (ensure kubectl is installed and configured)
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Clean up workspace
        }
    }
}
