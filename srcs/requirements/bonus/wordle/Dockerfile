FROM alpine:3.17.2

RUN set -ex; \
	apk add --no-cache \
	nodejs \
	npm

COPY ./web/ /var/www/html/

WORKDIR /var/www/html

RUN set -ex; \
	if [ ! -d ./node_modules ]; then \
		npm install; \
	fi

EXPOSE 3000

ENTRYPOINT [ "npm", "run", "server" ]