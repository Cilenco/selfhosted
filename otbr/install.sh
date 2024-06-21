#!/bin/bash

CONFIG_FILE=$HOME/config.ini

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)
(envsubst < templates/docker-compose.yml) > docker-compose.yml

echo "Finished setup. Please execute 'sudo modprobe ip6table_filter' now"
