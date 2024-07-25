#!/bin/bash

CONFIG_FILE=$HOME/config.ini

rm -rf config
mkdir config

rm -rf secrets
mkdir secrets

rm -rf ldap
mkdir ldap

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)

export JWT_SECRET=$(openssl rand -hex 64)
export KEY_SEED=$(openssl rand -hex 64)

read    -p "Username: " USERNAME && export USERNAME
read -s -p "Password: " PASSWORD && export PASSWORD

read -p "E-Mail: " EMAIL && export EMAIL

echo $JWT_SECRET > secrets/JWT_SECRET

openssl rand -hex 64 > secrets/STORAGE_ENCRYPTION_KEY
openssl rand -hex 64 > secrets/OIDC_HMAC_SECRET
openssl rand -hex 64 > secrets/SESSION_SECRET

openssl genrsa 4096 > secrets/OIDC_PRIVATE_KEY

(envsubst < templates/docker-compose.yml) > docker-compose.yml
(envsubst < templates/configuration.yml) > config/configuration.yml
(envsubst < templates/lldap_config.toml) > ldap/lldap_config.toml
