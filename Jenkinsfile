pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'java-microservice'
        DOCKER_REGISTRY = 'docker.io' // Docker Hub registry
        DOCKER_HUB_REPO = 'bhargavakulla/java-microservice' // Update to your Docker Hub repo
        IMAGE_TAG = "${env.BUILD_ID}"
        K8S_DEPLOYMENT = 'microservice-deployment'
        K8S_NAMESPACE = 'default'
        REPO_URL = 'https://github.com/Bhargavkulla/CI-CD.git'
        GIT_CREDENTIALS = 'github-credentials' // Assuming you have credentials set in Jenkins
        GIT_BRANCH = 'main'  // Ensure this matches your repo's default branch
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git credentialsId: "${GIT_CREDENTIALS}", url: "${REPO_URL}", branch: "${GIT_BRANCH}"
            }
        }

        stage('Setup Python') {
            steps {
                script {
                    sh 'sudo apt-get update'
                    sh 'sudo apt-get install -y python3 python3-pip'
                    sh 'pip install -r requirements.txt'
                }
            }
        }

        stage('Test with Pytest') {
            steps {
                script {
                    sh 'pytest tests/'
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh '''
                        docker build -t ${DOCKER_REGISTRY}/${DOCKER_HUB_REPO}:${IMAGE_TAG} .
                    '''
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker_credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh '''
                            echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                            docker push ${DOCKER_REGISTRY}/${DOCKER_HUB_REPO}:${IMAGE_TAG}
                        '''
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                        kubectl set image deployment/${K8S_DEPLOYMENT} ${K8S_DEPLOYMENT}=${DOCKER_REGISTRY}/${DOCKER_HUB_REPO}:${IMAGE_TAG} --namespace=${K8S_NAMESPACE}
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Clean up the workspace
        }
        success {
            echo 'Build and deployment succeeded!'
        }
        failure {
            echo 'Build or deployment failed.'
        }
    }
}
