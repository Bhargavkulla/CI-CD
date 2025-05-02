pipeline {
    agent any
    environment {
        PATH = "${env.PATH}:/var/lib/jenkins/.local/bin"
    }
    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }
        
        stage('Setup Python') {
            steps {
                script {
                    // Update and install python3 and pip
                    sh '''#!/bin/bash
                    sudo apt-get update
                    sudo apt-get install -y python3 python3-pip
                    '''
                }
            }
        }
        
        stage('Test with Pytest') {
            steps {
                script {
                    // Install dependencies and run pytest
                    sh '''#!/bin/bash
                    pip install -r requirements.txt
                    pytest tests/
                    '''
                }
            }
        }
        
        stage('Docker Build') {
            when {
                expression { return currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    // Add your Docker build steps here
                }
            }
        }
        
        stage('Docker Push') {
            when {
                expression { return currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    // Add your Docker push steps here
                }
            }
        }

        stage('Deploy to Kubernetes') {
            when {
                expression { return currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    // Add your Kubernetes deployment steps here
                }
            }
        }

        stage('Declarative: Post Actions') {
            steps {
                cleanWs()
            }
        }
    }
}
