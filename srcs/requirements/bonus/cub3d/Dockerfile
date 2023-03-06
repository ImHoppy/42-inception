FROM alpine:3.17.2

RUN set -ex; \
	apk add --no-cache \
	nodejs \
	npm

COPY ./server.js /var/cub3d/

WORKDIR /var/cub3d/

EXPOSE 1977

ENTRYPOINT [ "node", "server.js" ]