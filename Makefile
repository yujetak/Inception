VOLUME_DIR	:=	/Users/yuje/Downloads/Inception

# DOCKER_COMPOSE	:=	docker compose
# DOCKER_COMPOSE	:=	/goinfre/yotak/chrome_download/docker-compose-darwin-x86_64
DOCKER_COMPOSE	:=	/Users/yuje/Downloads/docker-compose-darwin-x86_64
DOCKER_COMPOSE_FILE	:=	./srcs/docker-compose.yml
PROJECT_NAME	:=	Inception
DOCKER_NAME_LIST := $(docker ps -a -q)

.PHONY:	all
all:
	mkdir -p $(VOLUME_DIR)/db
	mkdir -p $(VOLUME_DIR)/wordpress
	chmod +x $(DOCKER_COMPOSE)
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
	docker system prune -f -a
	docker volume prune -f

.PHONY: fclean
fclean: clean
	rm -rf $(VOLUME_DIR)/db/*
	rm -rf $(VOLUME_DIR)/wordpress/*
.PHONY: re
re: fclean all

##
# 1. mariadb setting
# 2. makefile
# 3. volumes 경로 주의
# 4. sleep -> health check로 바꾸면 굉장히 좋긴 함
# 5. 오늘 바꾼거: nginx.conf, wp-config.php COPY 경로, USER => USER_ID (이름 겹침)
# 6. init process 공부하기
##