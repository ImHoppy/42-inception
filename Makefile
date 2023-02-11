DOCKER_FLAGS = -f srcs/docker-compose.yml

all: build

build:
	docker compose ${DOCKER_FLAGS} up -d --build
restart:
	docker compose ${DOCKER_FLAGS} restart
start:
	docker compose ${DOCKER_FLAGS} start
stop:
	docker compose ${DOCKER_FLAGS} stop
clean:
	docker compose ${DOCKER_FLAGS} rm -f
fclean:
	docker compose ${DOCKER_FLAGS} rm -v

.PHONY: build start stop clean fclean
