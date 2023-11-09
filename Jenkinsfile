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
                sh ' sudo docker build --load -t himanshukr0612/webserver:${BUILD_TAG} .'
                // script{
                    // def imageTag = "himanshukr0612/webserver:${BUILD_TAG}"
                    // sh "sudo docker build -t $imageTag ."
                    // sh "sudo docker tag $imageTag $imageTag"
                    // sh "sudo docker push $imageTag"
                // }
            }
        }
        stage('Push Image Into Docker Hub'){
            steps{
                withCredentials([string(credentialsId: 'DockerHubPassword', variable: 'DockerHubPassword')]) {
                    sh 'sudo docker login -u himanshukr0612 -p $DockerHubPassword'
                }
                sh 'sudo docker push himanshukr0612/webserver:${BUILD_TAG}'
            }
        }
        stage('Deploy Webapp In Dev Environment'){
            steps{
                sh 'sudo docker rm -f mywebserver'
                sh 'sudo docker run -d -p 1234:80 --name mywebserver  docker.io/himanshukr0612/webserver:${BUILD_TAG}'

            }
        }
        stage('Launch Container In Testing Environment'){
             steps{
                sh 'sudo docker rm -f deploy'
                sh 'sudo docker run -d -p 8080:80 --name mywebserver  docker.io/himanshukr0612/webserver:${BUILD_TAG}'
            }
        }
        // stage('Launch Container In Testing Environment'){
        //     steps{
        //         sshagent(['Environment-Key']) {
        //             sh "ssh -o StrictHostKeyChecking=no ec2-user@65.0.168.35 sudo  docker rm -f mywebserver"
        //             sh "ssh -o StrictHostKeyChecking=no ec2-user@65.0.168.35 sudo docker run -d -p 80:80 --name mywebserver docker.io/himanshukr0612/webserver:${BUILD_TAG}"
        //         }
        //     }
        // }
        stage('Testing Phase'){
            steps{
                sh 'curl -sleep http://65.0.168.35:8080/ | grep DevOps'
                sh 'curl -sleep http://65.0.168.35:8080/ | grep Jenkins'
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
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@65.0.168.35 sudo docker rm -f prod"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@65.0.168.35 sudo docker run -d -p 1234:80 --name prod docker.io/himanshukr0612/webserver:${BUILD_TAG}"
                }
            }
        }
    }
}