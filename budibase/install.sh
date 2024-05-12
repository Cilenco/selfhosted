#!/bin/bash

if [[ -z "${DOMAIN}" ]]; then
  read -p "Enter domain: " DOMAIN && export DOMAIN
fi

(envsubst < templates/docker-compose.yml) > docker-compose.yml
