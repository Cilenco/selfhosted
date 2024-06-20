#!/bin/bash

CONFIG_FILE=$HOME/config.ini

rm -rf workdir
rm -rf confdir

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)
(envsubst < templates/docker-compose.yml) > docker-compose.yml
