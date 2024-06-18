#!/bin/bash

# Variables
MYSQL_ROOT_PASSWORD="(password)"
DATABASE_NAME="tyrell_corp"
TABLE_NAME="nexus6"
MYSQL_USER="holberton_user"

# MySQL commands
CREATE_DATABASE_CMD="CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};"
CREATE_TABLE_CMD="CREATE TABLE IF NOT EXISTS ${DATABASE_NAME}.${TABLE_NAME} (
  id INT AUTO_INCREMENT PRIMARY KEY,
  model VARCHAR(50),
  production_year INT
);"
INSERT_ENTRY_CMD="INSERT INTO ${DATABASE_NAME}.${TABLE_NAME} (model, production_year) VALUES ('Nexus-6', 2019);"
GRANT_PERMISSIONS_CMD="GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${MYSQL_USER}'@'localhost'; FLUSH PRIVILEGES;"
                                                    
# Function to execute MySQL commands
execute_mysql_command() {
  local CMD=$1
  mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "${CMD}"
}

# Create database
echo "Creating database ${DATABASE_NAME}..."
execute_mysql_command "${CREATE_DATABASE_CMD}"
echo "Database ${DATABASE_NAME} created."

# Create table
echo "Creating table ${TABLE_NAME} in database ${DATABASE_NAME}..."
execute_mysql_command "${CREATE_TABLE_CMD}"
echo "Table ${TABLE_NAME} created."

# Insert entry into table
echo "Inserting entry into table ${TABLE_NAME}..."
execute_mysql_command "${INSERT_ENTRY_CMD}"
echo "Entry inserted into table ${TABLE_NAME}."

# Grant permissions to user
echo "Granting permissions to user ${MYSQL_USER}..."
execute_mysql_command "${GRANT_PERMISSIONS_CMD}"
echo "Permissions granted to user ${MYSQL_USER}."

echo "Database setup completed."
