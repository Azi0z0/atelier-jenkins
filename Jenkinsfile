pipeline {
    agent any

    environment {
        IMAGE_NAME = "laziz0/alpine"
        DOCKER_CRED = "dockerhub-cred"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withCredentials([string(credentialsId: 'SONAR_AUTH_TOKEN', variable: 'TOKEN')]) {
                    sh """
                      mvn sonar:sonar \
                      -Dsonar.projectKey=atelier-jenkins \
                      -Dsonar.host.url=http://localhost:9000 \
                      -Dsonar.login=$TOKEN
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:1.0.0 ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: DOCKER_CRED,
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${IMAGE_NAME}:1.0.0"
                }
            }
        }
    }
}

