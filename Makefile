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
	sudo docker-compose -f ./srcs/docker-compose.yml build
	sudo docker-compose -f ./srcs/docker-compose.yml up -d

clean:
	sudo docker container stop nginx mariadb wordpress
	sudo docker network rm inception

fclean: clean
	@sudo rm -rf /home/ccouliba/data/mariadb/*
	@sudo rm -rf /home/ccouliba/data/wordpress/*
	@docker system prune -af

re: fclean all

.PHONY: all clean fclean
