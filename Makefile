DOCKER_NAME = inception
DOCKER_FILE = srcs/docker-compose.yml


DOCKER_FLAGS = -f ${DOCKER_FILE} -p ${DOCKER_NAME}

include ./srcs/.env
VOLUMES_DIR = $(VOLUME_WP_PATH) $(VOLUME_DB_PATH) $(VOLUME_WORDLE_PATH)
make_dir:
	mkdir -p $(VOLUMES_DIR)

all: build

dev: make_dir
	docker compose ${DOCKER_FLAGS} up --build
build: make_dir
	docker compose ${DOCKER_FLAGS} up -d --build
restart:
	docker compose ${DOCKER_FLAGS} restart
logs:
	docker compose ${DOCKER_FLAGS} logs -f
down:
	docker compose ${DOCKER_FLAGS} down
fulldown:
	docker compose ${DOCKER_FLAGS} down -t 3 --rmi all --volumes
clean:
	# Clean Docker Image
	docker rmi -f nginx
	docker rmi -f wordpress
	docker rmi -f mariadb
	# Clean Docker Containers
	docker compose ${DOCKER_FLAGS} rm -sfv

fullclean:
	-docker stop $(shell docker ps -qa)
	-docker rm $(shell docker ps -qa)
	-docker rmi -f $(shell docker images -qa)
	-docker volume rm $(shell docker volume ls -q);
	-sudo rm -rf $(VOLUMES_DIR)
	-docker network rm $(shell docker network ls -q) 2>/dev/null

re: fulldown all

.DEFAULT_GOAL = all
.PHONY: build clean fullclean down fulldown restart logs re
