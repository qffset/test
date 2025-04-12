pipeline {
    agent {
        label 'Chirik' // Указываем конкретный агент для выполнения всего pipeline
    }

        stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/qffset/test.git', branch: 'main'
            }
        }

            
            
        stage('Unit Tests') {
            steps {
                sh 'go test ./...'
            }
        }

    
        stage('Build Image') {
            steps {
                sh "docker build -t test ."
            }
        }

    stage('Cleanup') {
            steps {
                sh '''
                    # Очистка старых контейнеров
                     docker stop go_test
                     docker rm go_test
                    # Очистка старых образов
                    # docker image prune -af
                '''
            }
        }


        stage('Run Docker Container') {
            steps {
               sh 'docker run -d -p 8080:8080 --name go_test test'
            }
        }
    
    }
}