DOCKER_COMPOSE	:=	docker compose
DOCKER_COMPOSE_FILE	:=	./srcs/docker-compose.yml
PROJECT_NAME	:=	Inception
DOCKER_NAME_LIST := $(docker ps -a -q)

.PHONY:	all
all:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up --build

.PHONY:	build
build:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) build

.PHONY:	up
up:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up

.PHONY:	down
down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

.PHONY: clean
clean: down
	docker volume prune -f
	docker system prune -f -a

.PHONY: fclean
fclean: clean
	# rm -rf ./db
	# rm -rf ./wordpress
.PHONY: re
re: fclean all