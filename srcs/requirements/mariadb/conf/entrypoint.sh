
mkdir -p ${VOLUME_WP_PATH}
mkdir -p ${VOLUME_DB_PATH}

echo "--------------- Mysql Install ---------------"
mysql_install_db -uroot --basedir=/usr --datadir=/var/lib/mysql
mariadbd -uroot & sleep 2
echo "--------------- Inject SQL ---------------"
mysql << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
echo "--------------- Kill Mysql ---------------"
killall mariadbd
echo "--------------- Starting Mysql ---------------"
mariadbd -uroot