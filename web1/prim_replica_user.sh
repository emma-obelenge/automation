#!/bin/bash

# Default Variables
DEFAULT_REPLICA_USER="replica_user"
DEFAULT_REPLICA_PASSWORD="password"  # Default password, can be changed
HOST="%"
DEFAULT_MYSQL_ROOT_PASSWORD="(password)"

# Prompt for REPLICA_USER and REPLICA_PASSWORD, use defaults if not provided
read -p "Enter replica username, default is [${DEFAULT_REPLICA_USER}]: " REPLICA_USER
REPLICA_USER=${REPLICA_USER:-$DEFAULT_REPLICA_USER}

read -s -p "Enter replica password, default is [${DEFAULT_REPLICA_PASSWORD}]: " REPLICA_PASSWORD
echo
REPLICA_PASSWORD=${REPLICA_PASSWORD:-$DEFAULT_REPLICA_PASSWORD}

# Prompt for MYSQL_ROOT_PASSWORD, use default if not provided
read -s -p "Enter MySQL root password, default is [${DEFAULT_MYSQL_ROOT_PASSWORD}]: " MYSQL_ROOT_PASSWORD
echo
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-$DEFAULT_MYSQL_ROOT_PASSWORD}

# MySQL commands
CREATE_REPLICA_USER_CMD="SET GLOBAL validate_password.policy=LOW;
SET GLOBAL validate_password.length=6;
CREATE USER '${REPLICA_USER}'@'${HOST}' IDENTIFIED BY '${REPLICA_PASSWORD}';
GRANT REPLICATION SLAVE ON *.* TO '${REPLICA_USER}'@'${HOST}';
FLUSH PRIVILEGES;
SET GLOBAL validate_password.policy=MEDIUM;"

GRANT_SELECT_CMD="GRANT SELECT ON mysql.user TO 'holberton_user'@'localhost';
FLUSH PRIVILEGES;"

# Function to execute MySQL commands
execute_mysql_command() {
  local CMD=$1
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "${CMD}"
}

# Create replica user and grant necessary permissions
echo "Creating replica user ${REPLICA_USER} and granting replication permissions..."
execute_mysql_command "${CREATE_REPLICA_USER_CMD}"
echo "Replica user ${REPLICA_USER} created and permissions granted."

# Grant SELECT privileges to holberton_user on mysql.user table
echo "Granting SELECT privileges to holberton_user on mysql.user table..."
execute_mysql_command "${GRANT_SELECT_CMD}"
echo "SELECT privileges granted to holberton_user on mysql.user table."

echo "Setup completed."
