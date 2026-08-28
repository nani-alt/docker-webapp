pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                sh 'echo "Jenkins is working!"'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t my-webapp:jenkins .'
            }
        }

        stage('Docker Test') {
            steps {
                sh '''
                    docker rm -f jenkins-test || true
                    docker run -d --name jenkins-test -p 8084:80 my-webapp:jenkins
                    sleep 3
                    curl -f http://localhost:8084
                    docker rm -f jenkins-test
                '''
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: '61c393da-9cc8-4499-b3dc-9e8e866bc66e',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker tag my-webapp:jenkins nanii12345/my-webapp:jenkins
                        docker push nanii12345/my-webapp:jenkins
                        docker logout
                    '''
                }
            }
        }
		stage('Deploy') {
    steps {
        sh '''
            docker pull nanii12345/my-webapp:jenkins
            docker rm -f my-webapp-prod || true
            docker run -d --name my-webapp-prod -p 8085:80 nanii12345/my-webapp:jenkins
            sleep 3
            curl -f http://localhost:8085
        '''
    }
}
    }
}
