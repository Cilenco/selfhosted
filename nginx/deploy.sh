#!/bin/sh

FILE_NAME="${LEGO_CERT_DOMAIN#\*.}"

cp -f $LEGO_CERT_PATH /app/certificates/$FILE_NAME.crt 
cp -f $LEGO_CERT_KEY_PATH /app/certificates/$FILE_NAME.key

curl --unix-socket /var/run/docker.sock -X POST http://localhost/containers/nginx-proxy/restart
