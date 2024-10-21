#!/bin/bash

docker volume create certs > /dev/null

CONFIG_FILE=$HOME/config.ini

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)
export EMAIL=$(crudini --get $CONFIG_FILE general email)

export PREFIX=$(crudini --get $CONFIG_FILE ionos prefix)
export SECRET=$(crudini --get $CONFIG_FILE ionos secret)

(envsubst < docker/compose.yml) > compose.yml
