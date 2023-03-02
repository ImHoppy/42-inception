FROM alpine:3.17.2

RUN set -ex; \
	apk add --no-cache \
	php81 \
	php81-fpm \
	php81-session \
	php81-mysqli

RUN set -ex; \
	adduser -u 82 -D -S -G www-data www-data; \
	[ ! -d /var/www/html ]; \
	mkdir -p /var/www/html; \
	chown www-data:www-data /var/www/html; \
	chmod 777 /var/www/html;

WORKDIR /var/www/html

ENV	ADMINER_VERSION 4.8.1

ADD --chown=www-data:www-data https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php /var/www/html/index.php

COPY ./adminer.conf /etc/php81/php-fpm.d/www.conf

EXPOSE 9000

ENTRYPOINT [ "php-fpm81", "-F", "--allow-to-run-as-root", "--force-stderr" ]