# Version of the image (Debian env)
FROM debian:buster

# Install updates and upgrades
RUN apt-get update -y && apt-get upgrade -y

# Install NGINX and dependencies
RUN apt-get install -y \
    nginx \
    vim \
    curl

## Creation of a folder for stocking the cert and the key for a secured connexion
RUN mkdir -p /etc/nginx/ssl

## Using ssl tool to generate TLS cert
RUN apt-get install -y openssl

# Generate ssl private key and certificate :
#   -x509 -> cert type
#   -nodes-> private key will not have password
#   -out  -> where the cert will be stocked
#   -keyout-> where the key will be stocked
#   -subj -> we can give all infornmations needed by ssl to generate the key
#   -sha256 -> hash the cert/key in sha256 format
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=ccouliba.42.fr/UID=ccouliba"

# copy the provided config file to the container
RUN mkdir -p /var/run/nginx

# We put into a conf repertory, which is in nginx repertory
# Nginx config file should be replaced by MINE as the container starts
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Change the rigths for the files we will open/read/write
# For the root user
RUN chmod 755 /var/www/html
# For main user (Not root user)
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

# Will launch nginx in foreground (daemon off) for the container not to be stopped
##CAUTION : when i run just the NGINX container without WORDPRESS neither MariaDB, could be a problem
##Not forget to uncomment this when the 2 others containers are ready to be composed
CMD ["nginx", "-g", "daemon off;"]
