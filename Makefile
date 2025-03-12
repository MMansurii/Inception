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
DC = docker-compose -f Codes/docker-compose.yml --env-file Codes/.env
VOLUME_PATH = /home/mmansuri/data

# Default Target
all: up
	@echo "Running the inception...\n"

# create folders
folders:
	@mkdir -p $(VOLUME_PATH)/mysql
	@mkdir -p $(VOLUME_PATH)/wordpress

# Build the docker image
build:folders
	@echo "Building the inception...\n"
	@$(DC) build

# Run the docker container
up:build
	@$(DC) up 

# Stop the docker container
down:
	@echo "Stopping the inception...\n"
	@$(DC) down

# Stop the docker container
stop:
	@echo "Stopping the inception...\n"
	@$(DC) stop

# Start the docker container
start:
	@echo "Starting the inception...\n"
	@$(DC) start

# Restart the docker container
restart:
	@echo "Restarting the inception...\n"
	@$(DC) restart

clean:
	docker rm -f mariadb wordpress nginx
	docker rmi -f mariadb wordpress nginx
	docker volume rm $(shell docker volume ls -qf dangling=true)
	docker system prune -a -f

# Remove all the docker containers and images and start fresh
re: clean all

# Phony Targets
.PHONY: all build up down stop start restart clean re folders
