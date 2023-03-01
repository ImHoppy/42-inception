# syntax=docker/dockerfile:1
FROM alpine:3.17.2

RUN set -ex; \
	apk add --no-cache \
	$(apk search --no-cache -q 'php81-') \
	mariadb-client \
	curl; \
	adduser -u 82 -D -S -G www-data www-data; \
	[ ! -d /var/www/html ]; \
	mkdir -p /var/www/html; \
	chown www-data:www-data /var/www/html; \
	chmod 777 /var/www/html;

WORKDIR /var/www/html

ENV WORDPRESS_CLI_GPG_KEY 63AF7AA15067C05616FDDD88A3A2E8F226F0BC06
ENV WORDPRESS_CLI_VERSION 2.7.1

RUN set -ex; \
	php --version;\
	php -m;\
	apk add --no-cache --virtual .fetch-deps \
		gnupg \
	; \
	\
	curl -o /usr/local/bin/wp.gpg -fL "https://github.com/wp-cli/wp-cli/releases/download/v${WORDPRESS_CLI_VERSION}/wp-cli-${WORDPRESS_CLI_VERSION}.phar.gpg"; \
	\
	GNUPGHOME="$(mktemp -d)"; export GNUPGHOME; \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$WORDPRESS_CLI_GPG_KEY"; \
	gpg --batch --decrypt --output /usr/local/bin/wp /usr/local/bin/wp.gpg; \
	gpgconf --kill all; \
	rm -rf "$GNUPGHOME" /usr/local/bin/wp.gpg; unset GNUPGHOME; \
	\
	chmod +x /usr/local/bin/wp; \
	\
	apk del --no-network .fetch-deps; \
	\
	wp --allow-root --version

EXPOSE 9000

COPY ./conf/www.conf /etc/php81/php-fpm.d/www.conf
COPY ./conf/entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["sh", "/usr/bin/entrypoint.sh"]
# -F : run in foreground
CMD ["php-fpm81", "-F", "--allow-to-run-as-root", "--force-stderr"]
