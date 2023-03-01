FROM alpine:3.17.2

RUN set -ex; \
	apk add --no-cache \
	redis

COPY ./conf/redis.conf /etc/redis/redis.conf

EXPOSE 6379

ENTRYPOINT [ "redis-server", "/etc/redis/redis.conf" ]