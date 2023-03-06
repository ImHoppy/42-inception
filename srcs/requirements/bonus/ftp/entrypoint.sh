#!/bin/sh

grep -E "^$FTP_USER" /etc/passwd > /dev/null
if [ $? -eq 1 ]; then
	printf "\033[32;1m--------------- Creating FTP User ---------------\033[0m\n"
    adduser -D "$FTP_USER" && echo "$FTP_USER":"$FTP_PASSWORD" | chpasswd;
    [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
    chown -R "$FTP_USER":"$FTP_USER" /home/"$FTP_USER"
fi
echo "FTP Server started on port 21"
exec "$@"