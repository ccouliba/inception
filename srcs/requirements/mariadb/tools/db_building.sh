#!/bin/bash

# Start mysql service
service mysql start;

# Log into MariaDB as root and create database and the user
# Have to set all env_variables via docker-compose (or/and in .env file)
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
#mysqladmin -u root shutdown

# mysqld_safe is the recommended way to start a mysqld server on Unix.
# mysqld_safe adds some safety features such as
    # -restarting the server when an error occurs
    # -logging runtime information to an error log.
exec mysqld_safe

# Just a print status to make sure the script went to the end
echo "MariaDB database and user have been successfully created !"
