#!/bin/bash

rm -rf data
mkdir data

if [[ -z "${DOMAIN}" ]]; then
  read -p "Enter domain: " DOMAIN && export DOMAIN
fi

read -p "Enter Ionos API prefix: " PREFIX
read -p "Enter Ionos API secret: " SECRET

export API_KEY="$PREFIX.$SECRET"

(envsubst < templates/docker-compose.yml) > docker-compose.yml
(envsubst < templates/config.json) > data/config.json
