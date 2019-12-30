build:
	sudo docker-compose build

up:
	sudo docker-compose up -d

up-non-daemon:
	sudo docker-compose up

up-postgresql:
	sudo docker-compose up -d db_extracao

start:
	sudo docker-compose start

stop:
	sudo docker-compose stop

restart:
	sudo docker-compose stop && docker-compose start

shell-api:
	docker exec -ti api /bin/sh

shell-mongo:
	docker exec -ti mongo /bin/sh

log-api:
	docker-compose logs api_desafio

collectstatic:
	docker exec api /bin/sh -c "python manage.py collectstatic --noinput"

create-role:
	sudo docker exec -it db_extracao psql -U postgres -c "CREATE ROLE qbot_extracao LOGIN ENCRYPTED PASSWORD 'qbot_extracao' NOSUPERUSER INHERIT CREATEDB NOCREATEROLE NOREPLICATION;"

alter-role:
	sudo docker exec -it db_extracao psql -U postgres -c "ALTER ROLE qbot_extracao VALID UNTIL 'infinity'; ALTER USER qbot_extracao CREATEDB;"

create-db:
	sudo docker exec -it db_extracao psql -U postgres -c "CREATE DATABASE qbot_extracao WITH OWNER = qbot_extracao ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8' CONNECTION LIMIT = -1 TEMPLATE template0;"

run:
	sudo docker-compose run --service-ports api_desafio