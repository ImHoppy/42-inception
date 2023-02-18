# syntax=docker/dockerfile:1
FROM alpine:3.17.2
RUN apk add --no-cache nginx;
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
EXPOSE 443
COPY conf/entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT ["sh", "/usr/bin/entrypoint.sh"]
CMD ["nginx"]