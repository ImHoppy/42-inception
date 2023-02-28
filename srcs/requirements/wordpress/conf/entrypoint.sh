echo -e "\033[32;1m--------------- Waiting for mysql ---------------\033[0m"
until mariadb-admin --host=${WORDPRESS_DB_HOST} --user=${WORDPRESS_DB_USER} --password=${WORDPRESS_DB_PASSWORD} --silent ping; do
	echo -e "\033[32;1m--------------- Mysql is down ---------------\033[0m"
	sleep 4
done
if [ ! -f "/var/www/html/wp-config.php" ]; then
	echo -e "\033[32;1m--------------- Installing wordpress ---------------\033[0m"
	wp core download --path=/var/www/html

	wp config create \
		--path=/var/www/html \
		--dbname=$WORDPRESS_DB_NAME \
		--dbuser=$WORDPRESS_DB_USER \
		--dbpass=$WORDPRESS_DB_PASSWORD \
		--dbhost=$WORDPRESS_DB_HOST \
		--dbprefix=$WORDPRESS_TABLE_PREFIX

	wp core install \
		--path=/var/www/html \
		--url=$DOMAIN_NAME \
		--title=$WORDPRESS_TITLE \
		--admin_user=$WORDPRESS_ADMIN_USER \
		--admin_password=$WORDPRESS_ADMIN_PASSWORD \
		--admin_email=$WORDPRESS_ADMIN_EMAIL

	wp user create \
		$WORDPRESS_USER \
		$WORDPRESS_USER_EMAIL \
		--role=author \
		--user_pass=$WORDPRESS_USER_PASSWORD \
		--path=/var/www/html

	echo -e "\033[32;1m--------------- Wordpress installed ---------------\033[0m"
else
	echo -e "\033[32;1m--------------- Wordpress already installed ---------------\033[0m"
fi
echo -e "\033[32;1m--------------- Starting php-fpm ---------------\033[0m"
exec "$@"
