#!/bin/bash
CONFIG_FILE=$HOME/config.ini

rm -rf data
mkdir data

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)
export EMAIL=$(crudini --get $CONFIG_FILE general email)

export PREFIX=$(crudini --get $CONFIG_FILE ionos prefix)
export SECRET=$(crudini --get $CONFIG_FILE ionos secret)

export API_KEY="$PREFIX.$SECRET"

(envsubst < templates/docker-compose.yml) > docker-compose.yml
(envsubst < templates/config.json) > data/config.json
