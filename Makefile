DOCKER_NAME = inception
DOCKER_FILE = srcs/docker-compose.yml



DOCKER_FLAGS = -f ${DOCKER_FILE} -p ${DOCKER_NAME}

all: build

build:
	docker compose ${DOCKER_FLAGS} up -d --build
restart:
	docker compose ${DOCKER_FLAGS} restart
start:
	docker compose ${DOCKER_FLAGS} start
stop:
	docker compose ${DOCKER_FLAGS} stop
logs:
	docker compose ${DOCKER_FLAGS} logs -f
clean:
	docker compose ${DOCKER_FLAGS} rm -f
fclean: clean
	# Clean Docker Image
	docker rmi -f nginx
	docker rmi -f wordpress
	docker rmi -f mariadb
	# Clean Docker Containers
	docker compose ${DOCKER_FLAGS} rm -v

re: stop fclean all

.PHONY: build start stop clean fclean
