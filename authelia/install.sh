#!/bin/bash

read -p "Enter domain: " DOMAIN && export DOMAIN

export ENCRYPTION_KEY=$(openssl rand -hex 64)
export SESSION_SECRET=$(openssl rand -hex 64)

export HMAC_SECRET=$(openssl rand -hex 64)
export JWT_SECRET=$(openssl rand -hex 64)

export PRIVATE_KEY=$(openssl genrsa 4096)

rm -rf config
mkdir config

(envsubst < templates/docker-compose.yml) > docker-compose.yml
(envsubst < templates/configuration.yml) > config/configuration.yml

echo "users:" > config/users_database.yml
