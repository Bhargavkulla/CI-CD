pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = 'bhargavakulla/java-microservice:latest'
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
                    // Explicit closure syntax added here
                    sh 'sudo apt-get update'
                    sh 'sudo apt-get install -y python3 python3-pip'
                    sh 'sudo pip3 install -r requirements.txt'
                }
            }
        }

        stage('Test with Pytest') {
            steps {
                script {
                    // Explicit closure syntax added here
                    sh 'pytest tests/'
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Explicit closure syntax added here
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Docker push command if needed
                    // sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Kubernetes deployment command if needed
                }
            }
        }

        stage('Post Actions') {
            steps {
                script {
                    // Additional actions if required
                }
            }
        }
    }
}
