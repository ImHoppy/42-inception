#!/bin/sh

mkdir -p "$VOLUME_WP_PATH"
mkdir -p "$VOLUME_DB_PATH"

if [ ! -d /var/lib/mysql/"$MYSQL_DATABASE" ]; then
	printf "\033[32;1m--------------- Mysql Install ---------------\033[0m\n"
	mysql_install_db -uroot --basedir=/usr --datadir=/var/lib/mysql
	mariadbd -uroot & sleep 2
	printf "\033[32;1m--------------- Inject SQL ---------------\033[0m\n"
	until mysqladmin ping; do
		sleep 2
	done
	mysql <<- EOF
		CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
		CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
		GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
		FLUSH PRIVILEGES;
	EOF
	printf "\033[32;1m--------------- Kill Mysql ---------------\033[0m\n"
	killall mariadbd
fi
printf "\033[32;1m--------------- Starting Mysql ---------------\033[0m\n"
mariadbd -uroot
