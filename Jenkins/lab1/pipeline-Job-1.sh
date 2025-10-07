pipeline {
    agent any
    stages {
        stage('Hello Jenkins') {
            steps {
                sh 'echo "hello world" '
            }
        }
    }
}