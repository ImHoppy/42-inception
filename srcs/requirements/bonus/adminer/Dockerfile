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
&&	mkdir /var/www/html/plugins-enabled \
&&	chown -R adminer:adminer /var/www/html

USER adminer

WORKDIR /var/www/html

ENV	ADMINER_VERSION 4.8.1

ADD https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php /var/www/html/index.php

EXPOSE 9000
ENTRYPOINT [ "php-fpm81", "-F", "--force-stderr" ]