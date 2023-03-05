# syntax=docker/dockerfile:1
FROM alpine:3.17.2
RUN apk add --no-cache mariadb mariadb-client; \
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysql /var/lib/mysql /var/run/mysqld; \
	chmod 777 /var/lib/mysql

COPY ./conf/50-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./conf/entrypoint.sh /usr/bin/entrypoint.sh

ENTRYPOINT ["sh", "/usr/bin/entrypoint.sh"]
EXPOSE 3306
