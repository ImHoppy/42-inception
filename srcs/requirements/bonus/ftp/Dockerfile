FROM alpine:3.17.2

RUN set -ex; \
	apk add --no-cache \
	vsftpd

COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 20 21

ENTRYPOINT [ "vsftpd" ]