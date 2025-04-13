pipeline {
    agent {
        label 'Chirik' // Указываем конкретный агент для выполнения всего pipeline
    }
        
        stage('Build') {
            steps {
                echo "Building ${env.BRANCH_NAME}..."
                // Команда для сборки

            }
        }
        stage('Test') {
            steps {
                echo "Testing ${env.BRANCH_NAME}..."
                sh 'docker run -d -p 8080:8080 --name go_test test'

}
            }
        }
        stage('Deploy') {
            when {
                expression { env.BRANCH_NAME == 'main' }
            }
            steps {
                echo "Deploying ${env.BRANCH_NAME}..."
                sh 'docker run -d -p 8080:8080 --name go_test test'
            }
        }
    }
}