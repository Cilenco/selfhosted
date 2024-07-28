#!/bin/bash

CONFIG_FILE=$HOME/config.ini

rm -rf postgres
mkdir postgres

rm -rf data
mkdir data

export OUTLINE_SECRET_KEY=$(openssl rand -hex 32)
export OUTLINE_UTILS_SECRET=$(openssl rand -hex 32)

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)

export SMTP_SERVER=$(crudini --get $CONFIG_FILE smtp server)
export SMTP_PORT=$(crudini --get $CONFIG_FILE smtp port)

export SMTP_USERNAME=$(crudini --get $CONFIG_FILE smtp username)
export SMTP_PASSWORD=$(crudini --get $CONFIG_FILE smtp password)

(envsubst < templates/docker-compose.yml) > docker-compose.yml

(envsubst < templates/env.outline) > env.outline
