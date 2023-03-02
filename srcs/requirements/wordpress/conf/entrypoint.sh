#!/bin/sh

printf "\033[32;1m--------------- Waiting for mysql ---------------\033[0m"
until mariadb-admin --host="$WORDPRESS_DB_HOST" --user="$WORDPRESS_DB_USER" --password="$WORDPRESS_DB_PASSWORD" --silent ping; do
	printf "\033[32;1m--------------- Mysql is down ---------------\033[0m"
	sleep 4
done

_wp() {
	wp --allow-root --path=/var/www/html "$@"
}

if [ ! -f "/var/www/html/wp-config.php" ]; then
	printf "\033[32;1m--------------- Installing wordpress ---------------\033[0m"
	_wp core download

	_wp config create \
		--dbname="$WORDPRESS_DB_NAME" \
		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$WORDPRESS_DB_PASSWORD" \
		--dbhost="$WORDPRESS_DB_HOST" \
		--dbprefix="$WORDPRESS_TABLE_PREFIX"

	_wp core install \
		--url="$DOMAIN_NAME" \
		--title="$WORDPRESS_TITLE" \
		--admin_user="$WORDPRESS_ADMIN_USER" \
		--admin_password="$WORDPRESS_ADMIN_PASSWORD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL" \
		--skip-email

	_wp user create \
		"$WORDPRESS_USER" \
		"$WORDPRESS_USER_EMAIL" \
		--role=author \
		--user_pass="$WORDPRESS_USER_PASSWORD" \

	_wp config set --add --raw --type=constant \
	"WP_REDIS_HOST" "$WORDPRESS_REDIS_HOST"

	_wp config set --add --raw --type=constant \
	"WP_CACHE" true

	_wp config set --add --raw --type=constant \
	"WP_REDIS_SCHEME" "tcp"

	_wp plugin install \
		"$WORDPRESS_PLUGINS" \
		--activate \

	_wp redis enable

	printf "\033[32;1m--------------- Wordpress installed ---------------\033[0m"
else
	printf "\033[32;1m--------------- Wordpress already installed ---------------\033[0m"
fi
printf "\033[32;1m--------------- Starting php-fpm ---------------\033[0m"
exec "$@"
