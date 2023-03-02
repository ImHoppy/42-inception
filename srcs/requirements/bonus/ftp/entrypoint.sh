#!/bin/sh

grep -E "^$FTP_USER" /etc/passwd > /dev/null
if [ $? -eq 1 ]; then
    adduser -D "$FTP_USER"
	echo "$FTP_USER":"$FTP_PASSWORD" | chpasswd;
    chown -R "$FTP_USER":"$FTP_USER" /home/"$FTP_USER"
fi
echo "FTP Server started on port 21"
exec "$@"