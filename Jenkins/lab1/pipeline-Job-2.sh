pipeline {
    agent any
    parameters {
        string(name: 'FirstName', defaultValue: '', description: 'Please enter your first name')
        choice(name: 'Gender', choices: ['male', 'female'], description: 'Please select your gender')
        string(name: 'Age', defaultValue: '', description: 'Please enter your age')
    }
    stages {
        stage('Print Info') {
            steps {
                sh 'echo "My name is ${FirstName}"'
                sh 'echo "Gender: ${Gender}"'
                sh 'echo "Age: ${Age}"'
            }
        }
    }
}