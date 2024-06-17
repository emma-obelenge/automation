#!/bin/bash

# Variables
MYSQL_ROOT_PASSWORD="your_mysql_root_password"

# MySQL command to show all users
MYSQL_CMD="SELECT User, Host FROM mysql.user;"

# Function to show MySQL users
show_mysql_users() {
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "${MYSQL_CMD}"
}

# Execute the function to show MySQL users
echo "Showing all MySQL users on local machine..."
show_mysql_users
echo "Completed showing MySQL users."
