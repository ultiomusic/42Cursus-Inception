#!/bin/sh

if [ -f ./wp-config.php ]; then
	echo "wordpress is already downloaded"
else
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz  wordpress

	cd /var/www/html

	wp cli update
	/usr/local/bin/wp config create --dbname="${DB_NAME}" --dbuser="${DB_USER_USERNAME}" --dbpass="${DB_USER_PASSWORD}" --dbhost="${DB_HOST}" --force --allow-root
	/usr/local/bin/wp core install --allow-root --path=/var/www/html --url="https://${DOMAIN}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USERNAME}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}"
	/usr/local/bin/wp user create --allow-root "${WP_USER_USERNAME}" "${WP_USER_EMAIL}" --role="${WP_USER_ROLE}" --user_pass="${WP_USER_PASSWORD}"
fi
wp plugin update --all --allow-root 
exec "$@"