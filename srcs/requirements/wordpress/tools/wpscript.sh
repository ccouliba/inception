#!/bin/bash

# This script makes automatic the configuration of Wordpress
# Thanks to this, no need to pull the wp-config.php (Wordpress default config)

# To make sure database MariaDB will have enough time to be launched
sleep 10

cd /var/www/html/wordpress

# if ! wp core is-installed; then
wp config create --allow-root \
			--dbname=${SQL_DATABASE} \
			--dbuser=${SQL_USER} \
			--dbpass=${SQL_PASSWORD} \
			--dbhost=${SQL_HOST} \
			--url=https://${DOMAIN_NAME};
#wp config create --allow-root \
#			--dbname=$SQL_DATABASE \
#			--dbuser=$SQL_USER \
#			--dbpass=$SQL_PASSWORD \
#			--dbhost=mariadb:3306 --path='/var/www/wordpress'

# Configure the second page of Wordpress (wp core)
wp core install	--allow-root \
			--url=https://${DOMAIN_NAME} \
			--title=${SITE_TITLE} \
			--admin_user=${ADMIN_USER} \
			--admin_password=${ADMIN_PASSWORD} \
			--admin_email=${ADMIN_EMAIL};

# Create a second user
wp user create --allow-root \
			${USER1_LOGIN} ${USER1_MAIL} \
			--role=author \
			--user_pass=${USER1_PASS} ;

# Create a repertory for php if it does not exist
if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

# Start the PHP FastCGI Process Manager (FPM) for PHP version 7.3 (in the foreground)
exec /usr/sbin/php-fpm7.3 -F -R
