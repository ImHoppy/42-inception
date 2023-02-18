# syntax=docker/dockerfile:1
FROM alpine:3.17.2

ARG DOMAIN_NAME
ENV DOMAIN_NAME=${DOMAIN_NAME}

RUN apk add --no-cache nginx openssl; \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.pem \
	-subj "/C=FR/ST=Paris/L=Paris/O=42/CN=${DOMAIN_NAME}"
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
EXPOSE 443
COPY conf/entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["sh", "/usr/bin/entrypoint.sh"]
CMD ["nginx"]