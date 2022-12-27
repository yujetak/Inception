VOLUME_DIR	:=	/home/yotak/data

DOCKER_COMPOSE	:=	docker compose
DOCKER_COMPOSE_FILE	:=	./srcs/docker-compose.yml
PROJECT_NAME	:=	Inception
NETWORK_NAME := network-inception
DOCKER_NAME_LIST := $(docker ps -a -q)

.PHONY:	all
all:
	@mkdir -p $(VOLUME_DIR)/db
	@mkdir -p $(VOLUME_DIR)/wordpress
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
	docker system prune -f --all

.PHONY: fclean
fclean: clean
	@rm -rf $(VOLUME_DIR)/db/*
	@rm -rf $(VOLUME_DIR)/wordpress/*
	@docker volume rm $$(docker volume ls -q)

.PHONY: re
re: fclean all
