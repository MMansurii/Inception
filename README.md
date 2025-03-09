# Inception
A Docker-based project that sets up a full containerized system using Docker Compose. It includes Nginx, WordPress, and MariaDB, following the 42 Inception subject guidelines.
# Inception Project

## Overview
The **Inception Project** is a Docker-based system that follows the guidelines set by **42 School**. The goal is to containerize a complete web service using **Docker Compose**, ensuring each service runs in its own container.

## Features
- **Nginx**: Web server configured with SSL/TLS.
- **WordPress**: Fully functional CMS powered by PHP and MariaDB.
- **MariaDB**: Database management system for WordPress.
- **Docker Compose**: Manage services and networking.
- **Persistent Storage**: Data is retained even after container restarts.

## Project Structure
```
inception-project/
│── srcs/
│   ├── docker-compose.yml
│   ├── nginx/
│   │   ├── Dockerfile
│   │   ├── nginx.conf
│   ├── wordpress/
│   │   ├── Dockerfile
│   │   ├── wp-config.php
│   ├── mariadb/
│   │   ├── Dockerfile
│   │   ├── my.cnf
│── .gitignore
│── README.md
```

## Setup & Installation
### **1. Clone the Repository**
```sh
git clone https://github.com/your-username/inception-project.git
cd inception-project
```

### **2. Install Docker & Docker Compose**
Ensure you have **Docker** and **Docker Compose** installed:
```sh
sudo apt update && sudo apt install docker.io docker-compose -y
```

### **3. Build & Run the Containers**
```sh
cd srcs
docker-compose up --build -d
```

### **4. Check Running Containers**
```sh
docker ps
```

## Environment Variables
Create a `.env` file and configure the following:
```ini
DB_NAME=wordpress
DB_USER=admin
DB_PASSWORD=yourpassword
WP_ADMIN_USER=admin
WP_ADMIN_PASSWORD=securepassword
WP_ADMIN_EMAIL=admin@example.com
```

## Stopping & Cleaning Up
```sh
docker-compose down -v
```

## License
This project is licensed under the **MIT License** - see the LICENSE file for details.

---
Developed for **42 Inception Project** 🚀

