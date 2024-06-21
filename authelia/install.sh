#!/bin/bash

CONFIG_FILE=$HOME/config.ini

rm -rf config
mkdir config

rm -rf secrets
mkdir secrets

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)

openssl rand -hex 64 > secrets/STORAGE_ENCRYPTION_KEY

openssl rand -hex 64 > secrets/JWT_SECRET
openssl rand -hex 64 > secrets/OIDC_HMAC_SECRET
openssl rand -hex 64 > secrets/SESSION_SECRET

openssl genrsa 4096 > secrets/OIDC_PRIVATE_KEY

(envsubst < templates/docker-compose.yml) > docker-compose.yml
(envsubst < templates/configuration.yml) > config/configuration.yml

echo "users:" > config/users_database.yml
