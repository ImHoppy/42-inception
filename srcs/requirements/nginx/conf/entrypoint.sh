#!/bin/sh

printf "\033[32;1m--------------- Starting nginx ---------------\033[0m\n"

sed -i "s/example.com/${DOMAIN_NAME}/g" /etc/nginx/nginx.conf

exec "$@"
