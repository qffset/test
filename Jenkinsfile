pipeline {
    agent {
        label 'Teremok' // Указываем конкретный агент для выполнения всего pipeline
    }

        stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/qffset/test.git', branch: 'Develop'
            }
        }

            
            
        //stage('Unit Tests') {
            //steps {
            //    sh 'go test ./...'
          //  }
        //}

    
        
stage('Cleanup') {
    steps {
        script {
            // Проверяем, существует ли контейнер
            def containerFound = sh(script: 'docker ps -a | grep go_test', returnStatus: true)

            if (!containerFound) {
                echo "Контейнер go_test не найден."
            } else {
                try {
                    // Останавливаем контейнер
                    sh 'docker stop go_test || true'
                    
                    // Ждем завершения команды
                    sleep(5)  // Пауза на 5 секунд для уверенности

                    // Удаляем контейнер
                    sh 'docker rm -f go_test || true'

                    echo "Контейнер go_test успешно очищен."
                } catch (err) {
                    echo "Ошибка при очистке контейнера: ${err}"
                }
            }
        }
    }
}

stage('Build Image') {
            steps {
                //sh 'docker tag test:latest new-test:v1'
                sh "docker build -t test:latest ."
            }
        }



        stage('Run Docker Container') {
            steps {
               sh 'docker run -d -p 8080:8080 --name go_test test'
            }
        }
    
    }
}