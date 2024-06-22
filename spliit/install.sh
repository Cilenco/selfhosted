#!/bin/bash

CONFIG_FILE=$HOME/config.ini

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)
(envsubst < templates/docker-compose.yml) > docker-compose.yml

(envsubst < templates/env.spliit) > env.spliit
