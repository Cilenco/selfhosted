#!/bin/bash

if [[ -z "${DOMAIN}" ]]; then
  read -p "Enter domain: " DOMAIN && export DOMAIN
fi

export OUTLINE_SECRET_KEY=$(openssl rand -hex 32)
export OUTLINE_UTILS_SECRET=$(openssl rand -hex 32)

(envsubst < templates/env.outline) > env.outline
(envsubst < templates/docker-compose.yml) > docker-compose.yml
