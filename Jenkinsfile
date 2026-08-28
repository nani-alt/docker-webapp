
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
       			 sh 'docker run -d --name jenkins-test -p 8084:80 my-webapp:jenkins'
      		 	 sh 'sleep 3'
       			 sh 'curl -f http://localhost:8084'
       			 sh 'docker stop jenkins-test'
       			 sh 'docker rm jenkins-test'
   		 }
	}
	stage('Docker Push') {
    steps {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub-credentials',
            usernameVariable: 'DOCKER_USERNAME',
            passwordVariable: 'DOCKER_PASSWORD'
        )]) {
            sh '''
                echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                docker tag my-webapp:jenkins nanii12345/my-webapp:jenkins
                docker push nanii12345/my-webapp:jenkins
                docker logout
            '''
        }
    }
}
    }
}
