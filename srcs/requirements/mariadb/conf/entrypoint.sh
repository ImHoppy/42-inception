mariadbd -uroot &
mysql << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE user=''
DELETE FROM mysql.user WHERE user='root'
FLUSH PRIVILEGES;
EOF
killall mariadbd
exec "$@"