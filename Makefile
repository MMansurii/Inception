# Makefile for Inception Project

# Container Name
NAME = inception

# Docker Compose Path
DC = docker-compose -f srcs/docker-compose.yml --env-file srcs/.env
VOLUME_PATH =/home/mmansuri/data
VOLUME_PATH_CLEAN = /home/mmansuri

# Default Target
all: up
	@echo "Running the inception...\n"

# create folders
folders:
	@mkdir -p $(VOLUME_PATH)/mariadb
	@mkdir -p $(VOLUME_PATH)/wordpress

# Build the docker image
build:folders
	@echo "Building the inception...\n"
	@$(DC) build

# Run the docker container
up:build
	@$(DC) up -d
	@echo "Inception is up and running...\n"

# Start the docker container
start:
	@echo "Starting the inception...\n"
	@$(DC) start

# Restart the docker container
restart:
	@echo "Restarting the inception...\n"
	@$(DC) restart

# Stop the docker container
down:
	@echo "Stopping the inception...\n"
	@$(DC) down

# Stop the docker container
stop:
	@echo "Stopping the inception...\n"
	@$(DC) stop

# Stop and remove all containers related to the project
# Remove images associated with the project (forcefully)
# Clean up unused (dangling) volumes
# Perform a full system prune (remove all unused Docker data)
	
clean:
	@echo "Cleaning the inception...\n"
	@docker rm -f mariadb wordpress nginx
	@docker rmi -f mariadb wordpress nginx
	@docker volume rm $(shell docker volume ls -q)
	@docker system prune -a -f

# Remove all the docker containers and images and start fresh
re: clean all

# Phony Targets
.PHONY: all build up start restart down stop clean re folders
