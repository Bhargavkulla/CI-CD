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
                    // Fix: Added closure parameter list to eliminate ambiguity
                    sh 'sudo apt-get update'
                    sh 'sudo apt-get install -y python3 python3-pip'
                    sh 'sudo pip3 install -r requirements.txt'
                }
            }
        }

        stage('Test with Pytest') {
            steps {
                script {
                    // Fix: Added closure parameter list to eliminate ambiguity
                    sh 'pytest tests/'
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    // Fix: Added closure parameter list to eliminate ambiguity
                    sh "docker build -t ${DOCKER_IMAGE} ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Uncomment and fix if Docker push is required
                    // sh "docker push ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Add deployment script if necessary
                }
            }
        }

        stage('Post Actions') {
            steps {
                script {
                    // Add any post-build actions if necessary
                }
            }
        }
    }
}
