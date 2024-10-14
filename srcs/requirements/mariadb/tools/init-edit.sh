#! /bin/bash

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    service mariadb start

	sleep 3
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
    mysql -uroot -p${DB_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
    mysql -uroot -p${DB_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${DB_USER_USERNAME}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
    mysql -uroot -p${DB_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER_USERNAME}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
    mysql -uroot -p${DB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
	mariadb-admin -u root -p${DB_ROOT_PASSWORD} shutdown
	service mariadb stop
fi

exec "$@"