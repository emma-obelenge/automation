#!/bin/bash

# Default Variables
DEFAULT_USER="holberton_user"
DEFAULT_PASSWORD="projectcorrection280hbtn"
HOST="localhost"
MYSQL_ROOT_PASSWORD="(password)"
DEFAULT_DB="tyrell_corp"

# Prompt for USER and PASSWORD, use defaults if not provided
read -p "Enter MySQL username, default is [${DEFAULT_USER}]: " USER
USER=${USER:-$DEFAULT_USER}

read -s -p "Enter MySQL password, default is [${DEFAULT_PASSWORD}]: " PASSWORD
echo
PASSWORD=${PASSWORD:-$DEFAULT_PASSWORD}

 # Prompt for the Database name, use defaults if not provided
read -p "Enter DATABASE name for permission, default is [${DEFAULT_DB}]: " DATABASE_NAME
DATABASE_NAME=${DATABASE_NAME:-$DEFAULT_DB}

# MySQL commands
CHECK_USER_EXISTS_CMD="SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '${USER}' AND host = '${HOST}') AS user_exists;"

MYSQL_CMD="SET GLOBAL validate_password.policy=LOW;
CREATE USER '${USER}'@'${HOST}' IDENTIFIED BY '${PASSWORD}';
GRANT REPLICATION CLIENT ON *.* TO '${USER}'@'${HOST}';
GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${USER}'@'localhost' IDENTIFIED BY '${PASSWORD}';
FLUSH PRIVILEGES;
SET GLOBAL validate_password.policy=MEDIUM"

PERM="GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${USER}'@'${HOST}';
FLUSH PRIVILEGES;"

check_status() {
  USER_EXISTS=$(mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -N -e "${CHECK_USER_EXISTS_CMD}")
  if [ "$USER_EXISTS" -eq 0 ]; then
    #Execute the function to create the MySQL user
    echo "Creating MySQL user on local machine..."
    create_mysql_user
    echo "MySQL user creation completed on local machine."
  else
    echo "MySQL user ${USER} already exists."
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "${PERM}"
    echo "permission granted successfully"
  fi
}

# Function to create MySQL user locally
create_mysql_user() {
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "${MYSQL_CMD}"
}

check_status
