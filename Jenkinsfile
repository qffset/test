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
        // Очистка старых контейнеров
        script {
            try {
                sh 'docker stop go_test || true'
                sh 'docker rm go_test || true'
            } catch (err) {
                echo "Ошибка очистки контейнера: ${err}"
            }
        }
    }
}


        stage('Run Docker Container') {
            steps {
               sh 'docker run -d -p 8080:8080 --name go_test test'
            }
        }
    
    }
}