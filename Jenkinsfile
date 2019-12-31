node {
  stage 'Checkout'
  git url: 'https://github.com/helpthx/hello-jenkins'

  stage 'build postgres'
  checkout scm

  def postgresImage = docker.build('db_postgres')

  stage 'Create role in Postgres'

  postgresImage.inside {
        sh 'psql -U postgres -c "CREATE ROLE db_postgres LOGIN ENCRYPTED PASSWORD 'db_postgres' NOSUPERUSER INHERIT CREATEDB NOCREATEROLE NOREPLICATION;"'
    }

  stage 'Alter role in Postgres'

  postgresImage.inside {
        sh 'psql -U postgres -c "ALTER ROLE db_postgres VALID UNTIL 'infinity'; ALTER USER db_postgres CREATEDB;"'
    }

    stage 'Creating postgres database'

  postgresImage.inside {
        sh 'psql -U postgres -c "CREATE DATABASE db_postgres WITH OWNER = db_postgres ENCODING = 'UTF8' TABLESPACE = pg_default CONNECTION LIMIT = -1 TEMPLATE template0;"'
    }

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
