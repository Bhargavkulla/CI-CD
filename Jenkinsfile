pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = "bhargavakulla"
        DOCKER_IMAGE = "java-microservice"
        DOCKER_TAG = "latest"
        KUBERNETES_CLUSTER = "your-kubernetes-cluster"
        KUBERNETES_NAMESPACE = "default"
        IMAGE_NAME = "${DOCKER_REGISTRY}/${DOCKER_IMAGE}:${DOCKER_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test with Pytest') {
            steps {
                script {
                    // Run Pytest tests
                    sh 'pytest tests/'
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Login to Docker Hub and push the image
                    sh 'docker login -u ${DOCKER_REGISTRY} -p ${DOCKER_PASSWORD}'
                    sh 'docker push ${IMAGE_NAME}'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy to Kubernetes using kubectl
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
