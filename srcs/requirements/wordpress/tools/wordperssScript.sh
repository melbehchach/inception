#!/bin/bash

# Wait for mariadb to be reachable before attempting any wp-cli calls.
until (echo > /dev/tcp/mariadb/3306) 2>/dev/null; do
    sleep 2
done
sleep 2

# Update PHP-FPM listen port
sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --path=/var/www/html --allow-root
    wp config create --dbhost=mariadb --dbname=${MYSQL_DB_NAME} --dbuser=${MYSQL_USR} --dbpass=${MYSQL_PWD} --path=/var/www/html --allow-root --skip-check
    wp core install --url=${DOMAINE_NAME} --title="Wordpress page" --admin_name=${WP_USR} --admin_password=${WP_PWD} --admin_email="${ADMIN_EMAIL}" --path=/var/www/html --allow-root
    wp user create "${USER}" "${USER_EMAIL}" --user_pass=${WP_PWD} --allow-root --path=/var/www/html
fi

# Start PHP-FPM
mkdir -p /run/php
php-fpm7.4 -F