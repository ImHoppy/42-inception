
mkdir -p ${VOLUME_WP_PATH}
mkdir -p ${VOLUME_DB_PATH}

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; then
	echo -e "\033[32;1m--------------- Mysql Install ---------------\033[0m"
	mysql_install_db -uroot --basedir=/usr --datadir=/var/lib/mysql
	mariadbd -uroot & sleep 2
	echo -e "\033[32;1m--------------- Inject SQL ---------------\033[0m"
	until mysqladmin ping; do
		sleep 2
	done
	mysql << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
	echo -e "\033[32;1m--------------- Kill Mysql ---------------\033[0m"
	killall mariadbd
fi
echo -e "\033[32;1m--------------- Starting Mysql ---------------\033[0m"
mariadbd -uroot
