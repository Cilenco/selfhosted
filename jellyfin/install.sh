#!/bin/bash

CONFIG_FILE=$HOME/config.ini

rm -rf cache
rm -rf config

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)
(envsubst < templates/docker-compose.yml) > docker-compose.yml
