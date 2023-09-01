# COMPOSE = docker compose
# COMPOSE_FILE = ./srcs/docker-compose.yml
# DOCKER_LOGS = docker logs
# D_PRUNE = docker system prune
# D_CONTAINER = docker container
# D_NETWORK = docker network
# USER_DATA_PATH = /home/ccouliba/data/

all: 
	mkdir -p /home/ccouliba/data/mariadb
	mkdir -p /home/ccouliba/data/wordpress
	docker compose -f ./srcs/docker-compose.yml build
	docker compose -f ./srcs/docker-compose.yml up

run:
	docker compose -f ./srcs/docker-compose.yml up -d

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx

clean:
	docker container stop nginx mariadb wordpress
	docker network rm inception

fclean: clean
	@sudo rm -rf /home/ccouliba/data/mariadb/*
	@sudo rm -rf /home/ccouliba/data/wordpress/*
	@docker system prune -af

re: fclean all

.Phony: all logs clean fclean
