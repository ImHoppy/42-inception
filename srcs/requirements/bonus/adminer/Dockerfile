FROM alpine:3.17.2

RUN set -ex; \
	apk add --no-cache \
	php81 \
	php81-fpm \
	php81-session \
	php81-mysqli

RUN	addgroup -S adminer \
&&	adduser -S -G adminer adminer \
&&	mkdir -p /var/www/html \
&&	chown -R adminer:adminer /var/www/html

WORKDIR /var/www/html

ENV	ADMINER_VERSION 4.8.1

ADD https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php /var/www/html/index.php

COPY ./adminer.conf /etc/php81/php-fpm.d/adminer.conf

EXPOSE 9000

ENTRYPOINT [ "php-fpm81", "-F", "--allow-to-run-as-root", "--force-stderr" ]