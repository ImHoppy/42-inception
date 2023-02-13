# syntax=docker/dockerfile:1
FROM alpine:3.17.2
RUN apk add --no-cache mariadb mariadb-client; \
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
	chown -R mysql:root /run/mysqld
# COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./conf/entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["sh", "/usr/bin/entrypoint.sh"]
CMD ["mariadbd", "-uroot"]
EXPOSE 3306
