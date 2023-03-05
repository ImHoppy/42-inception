FROM alpine:3.17.2

RUN set -ex; \
	apk add --no-cache \
	vsftpd

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./entrypoint.sh /usr/bin/entrypoint.sh

ENTRYPOINT ["sh", "/usr/bin/entrypoint.sh"]
CMD [ "vsftpd", "/etc/vsftpd/vsftpd.conf"]

EXPOSE 20 21