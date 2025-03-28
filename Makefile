# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mmansuri <mmansuri@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/27 18:45:45 by mmansuri          #+#    #+#              #
#    Updated: 2024/12/20 17:12:52 by mmansuri         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Container Name
NAME = inception

# Docker Compose Path
DC = docker-compose -f srcs/docker-compose.yml --env-file srcs/.env
VOLUME_PATH =/workspaces/Inception/mmansuri/data
VOLUME_PATH_CLEAN = /workspaces/Inception/mmansuri

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
	sudo systemctl stop mariadb
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
	@docker ps -q --filter "name=mariadb\|wordpress\|nginx" | xargs -r docker rm -f
	@docker images -q mariadb wordpress nginx | xargs -r docker rmi -f
	@docker volume ls -qf dangling=true | xargs -r docker volume rm
	@docker system prune -a -f
	@sudo rm -rf $(VOLUME_PATH_CLEAN)

# Remove all the docker containers and images and start fresh
re: clean all

# Phony Targets
.PHONY: all build up start restart down stop clean re folders
