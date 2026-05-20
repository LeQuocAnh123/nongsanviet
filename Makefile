.PHONY: help up start setup wait-db down stop restart logs ps shell db-shell import-db export-db clean

COMPOSE ?= docker compose
WORDPRESS_SERVICE ?= wordpress
DB_SERVICE ?= db
DB_NAME ?= wordpress
DB_USER ?= wordpress
DB_PASSWORD ?= wordpress
DB_ROOT_PASSWORD ?= rootpassword
DB_DUMP ?= fruitlink-db.sql
SITE_URL ?= http://localhost:8080

help:
	@printf "Available commands:\n"
	@printf "  make up        Start the project in the background\n"
	@printf "  make setup     Start services and import the FruitLink database\n"
	@printf "  make start     Alias for make up\n"
	@printf "  make down      Stop and remove containers\n"
	@printf "  make stop      Stop containers without removing them\n"
	@printf "  make restart   Restart all services\n"
	@printf "  make logs      Follow container logs\n"
	@printf "  make ps        Show service status\n"
	@printf "  make shell     Open a shell in the WordPress container\n"
	@printf "  make db-shell  Open a MySQL shell\n"
	@printf "  make import-db Import $(DB_DUMP) into MySQL\n"
	@printf "  make export-db Export MySQL into $(DB_DUMP)\n"
	@printf "  make clean     Stop containers and remove volumes\n"

up:
	$(COMPOSE) up -d

setup: up wait-db import-db
	@printf "FruitLink is ready: $(SITE_URL)\n"

wait-db:
	@printf "Waiting for database to be ready"
	@for i in $$(seq 1 30); do \
		$(COMPOSE) exec -T $(DB_SERVICE) mysqladmin ping -h localhost -u root -p$(DB_ROOT_PASSWORD) --silent 2>/dev/null && { printf "\nDatabase ready.\n"; exit 0; }; \
		printf "."; \
		sleep 2; \
	done; \
	printf "\nDatabase did not become ready in time.\n" >&2; \
	exit 1

start: up

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

restart:
	$(COMPOSE) restart

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

shell:
	$(COMPOSE) exec $(WORDPRESS_SERVICE) bash

db-shell:
	$(COMPOSE) exec $(DB_SERVICE) mysql -u $(DB_USER) -p$(DB_PASSWORD) $(DB_NAME)

import-db:
	@test -f $(DB_DUMP) || { printf "Missing $(DB_DUMP). Run make export-db on a configured machine first.\n" >&2; exit 1; }
	@printf "Importing $(DB_DUMP) will replace the local $(DB_NAME) database.\n"
	$(COMPOSE) exec -T $(DB_SERVICE) mysql --default-character-set=utf8mb4 -u root -p$(DB_ROOT_PASSWORD) -e "DROP DATABASE IF EXISTS $(DB_NAME); CREATE DATABASE $(DB_NAME) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; GRANT ALL PRIVILEGES ON $(DB_NAME).* TO '$(DB_USER)'@'%'; FLUSH PRIVILEGES;"
	$(COMPOSE) exec -T $(DB_SERVICE) mysql --default-character-set=utf8mb4 -u $(DB_USER) -p$(DB_PASSWORD) $(DB_NAME) < $(DB_DUMP)

export-db:
	$(COMPOSE) exec -T $(DB_SERVICE) mysqldump --default-character-set=utf8mb4 --no-tablespaces -u$(DB_USER) -p$(DB_PASSWORD) $(DB_NAME) > $(DB_DUMP)

clean:
	$(COMPOSE) down -v
