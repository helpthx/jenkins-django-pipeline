node {
  stage 'Checkout'
  git url: 'https://github.com/helpthx/hello-jenkins'

  stage 'build'
  checkout scm
  
  def customImage = docker.build('api_hello_dev')

  stage 'Liting'

  customImage.inside {
        sh 'flake8 .'
    }
	
  stage 'Migrating'

  customImage.inside {
        sh 'python helloworld_project/manage.py migrate'
    }

  stage 'Make Migrations'

  customImage.inside {
        sh 'python helloworld_project/manage.py makemigrations'
    }
	
  stage 'Running'

  customImage.inside {
        sh 'python helloworld_project/manage.py runserver'
	sh 'sleep 5'
	sh 'docker kill api_hello_dev'
    }
		
}
