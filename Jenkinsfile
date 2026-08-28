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
    }
}
