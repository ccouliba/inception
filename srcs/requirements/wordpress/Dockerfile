# Version of the image (Debian env)
FROM debian:buster

# Install updates and upgrades
RUN apt-get update -y && apt-get upgrade -y

# Install wget in order to get Wordpress folder and php (for Wordpress) and their dependencies
RUN apt-get install -y \
    wget\
    php7.3 \
    php-fpm \
    php-mysql

# Command-line interface for WordPress (Wordpress-cli) then move it into the right container repertory
# Grant all rights to the wp-cli folder
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# Install mysql-client interface
RUN apt-get update && apt-get install -y default-mysql-client

# Install mariadb-client
RUN apt-get install -y mariadb-client

# Get WORDPRESS page then de-zip it
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html

# De-zip it in the right folder and remove the archive
RUN cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.1.1.tar.gz \
	&& rm /var/www/html/wordpress-6.1.1.tar.gz

# Ensure the web server(nginx) has the necessary permissions to read/execute the files within the web root directory
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

# Port WORDPRESS will use to communicate with NGINX
EXPOSE 9000

# Copy the WordPress script building script in the current repertory of the container
COPY ./tools/wpscript.sh ./

# Grant all rigths to the WordPress script
RUN chmod +x ./wpscript.sh

# Copy the wordpress conf in the right repertory of the container
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT ["bash", "./wpscript.sh"]
