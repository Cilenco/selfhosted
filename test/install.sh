#!/bin/bash

docker volume create certs > /dev/null

CONFIG_FILE=$HOME/config.ini

rm -rf config
mkdir config

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)
export EMAIL=$(crudini --get $CONFIG_FILE general email)

export PREFIX=$(crudini --get $CONFIG_FILE ionos prefix)
export SECRET=$(crudini --get $CONFIG_FILE ionos secret)

(envsubst < templates/docker-compose.yml) > docker-compose.yml

echo "client_max_body_size 10G;" > config/uploadsize.conf
echo "proxy_request_buffering off;" > config/uploadsize.conf
