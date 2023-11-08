pipeline {
    agent  any
    stages {
        stage('Pull Code From GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/Himanshu-kr-007/Jenkins-Company.git'
            }
        }
        stage('Build Docker Image'){
            steps{
                script{
                    def imageTag = "himanshukr0612/webserver:${BUILD_TAG}"
                    sh "docker build -t $imageTag ."
                    sh "docker tag $imageTag docker.example.com/$imageTag"
                    sh "docker push docker.example.com/$imageTag"
                }
                // sh ' sudo podman build -t himanshukr0612/webserver:${BUILD_TAG} .'
            }
        }
        stage('Push Image Into Docker Hub'){
            steps{
                withCredentials([string(credentialsId: 'DockerHubPassword', variable: 'DockerHubPassword')]) {
                    sh 'sudo podman login -u himanshukr0612 -p $DockerHubPassword'
                }
                sh 'sudo podman push himanshukr0612/webserver:${BUILD_TAG}'
            }
        }
        stage('Deploy Webapp In Dev Environment'){
            steps{
                sh 'sudo podman rm -f mywebserver'
                sh 'sudo podman run -d -p 80:80 --name mywebserver  docker.io/himanshukr0612/webserver:${BUILD_TAG}'

            }
        }
        stage('Launch Container In Testing Environment'){
            steps{
                sshagent(['Environment-Key']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.233.227.56 sudo  podman rm -f mywebserver"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.233.227.56 sudo podman run -d -p 80:80 --name mywebserver docker.io/himanshukr0612/webserver:${BUILD_TAG}"
                }
            }
        }
        stage('Testing Phase'){
            steps{
                sh 'curl -sleep http://13.233.227.56:80/ | grep DevOps'
                sh 'curl -sleep http://13.233.227.56:80/ | grep Jenkins'
            }
        }
        stage('Release To Production'){
            steps{
                input(message: "Release To Production?")
            }
        }
        stage('Deploy In Prod'){
            steps{
                sshagent(['Environment-Key']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.233.227.56 sudo podman rm -f prod"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@13.233.227.56 sudo podman run -d -p 1234:80 --name prod docker.io/himanshukr0612/webserver:${BUILD_TAG}"
                }
            }
        }
    }
}