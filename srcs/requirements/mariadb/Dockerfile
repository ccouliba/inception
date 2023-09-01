# Version of the image (Debian env)
FROM debian:buster

# Install updates and upgrades
RUN apt-get update -y && apt-get upgrade -y

# Install MariaDB and other dependencies ; Actually don't need client side
RUN apt-get install -y \
    mariadb-server \
    mariadb-client \
    procps

# Copy the provided config file in the container
# The default config file is named '50-server.cnf'
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Create folders to store mysql conf and stuff
RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/

# Change the rigths for the files we will open/read/write
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/

# TCP port number that the MariaDB/MySQL server will listen on for incoming client connections
EXPOSE 3306

# Copy the database building script in the current repertory of the container
COPY ./tools/db_building.sh ./

# give all rights to change the script
RUN chmod +x ./db_building.sh

# Will launch mariadb (sort of CMD cmd of a dockerfile)
ENTRYPOINT ["bash", "./db_building.sh"]
