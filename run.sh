#!/bin/sh

mkdir -p /var/nginx/client_body_temp
chown siplah:siplah /var/nginx/client_body_temp
mkdir -p /var/run/php/
chown siplah:siplah /var/run/php/
touch /var/log/php-fpm.log
chown siplah:siplah /var/log/php-fpm.log

if [ "$1" = 'app' ]; then
    exec supervisord --nodaemon --configuration="/etc/supervisord.conf" --loglevel=info
fi
