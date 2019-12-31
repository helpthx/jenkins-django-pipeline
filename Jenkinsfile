node {
  stage 'Checkout'
  git url: 'https://github.com/helpthx/hello-jenkins'

  stage 'build postgres'
  checkout scm

  def postgresImage = docker.build('db_postgres')

    sh 'make up-postgresql'

  stage 'Create role in Postgres'

  sh 'make create-role'

  stage 'Alter role in Postgres'

  sh 'make alter-role'

  stage 'Creating postgres database'

  sh 'make create-db'

  stage 'build app'
  checkout scm
  
  def customImage = docker.build('api_desafio')

  stage 'Style Guide Enforcement'

  customImage.inside {
        sh 'flake8 --ignore .'
    }
	
  stage 'Make Migrations'

  customImage.inside {
        sh 'python3 manage.py makemigrations produto'
        sh 'python3 manage.py makemigrations pedido'
    }

  stage 'Migrating for database'

  customImage.inside {
        sh 'python3 manage.py migrate'
    }

  stage 'Unit Testing for each app'

  customImage.inside {
        sh 'python3 manage.py test produto'
        sh 'python3 manage.py test pedido'
    }
}
