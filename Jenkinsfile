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
                sh 'docker tag test:latest new-test:v1'
                sh "docker build -t test ."
            }
        }

stage('Cleanup') {
    steps {
        script {
            // Проверяем, существует ли контейнер
            def containerExists = sh(script: 'docker ps -a | grep go_test', returnStatus: true)
            
            if (!containerExists) {
                echo "Контейнер go_test не найден."
            } else {
                try {
                    sh 'docker stop go_test || true'
                    sh 'docker rm -f go_test || true'
                } catch (err) {
                    echo "Ошибка очистки контейнера: ${err}"
                }
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