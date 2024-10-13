#!/bin/bash

CONFIG_FILE=$HOME/config.ini

export DOMAIN=$(crudini --get $CONFIG_FILE general domain)

export SMTP_SERVER=$(crudini --get $CONFIG_FILE smtp server)
export SMTP_PORT=$(crudini --get $CONFIG_FILE smtp port)

export SMTP_USERNAME=$(crudini --get $CONFIG_FILE smtp username)
export SMTP_PASSWORD=$(crudini --get $CONFIG_FILE smtp password)

read -p "Enter notification E-Mail: " EMAIL && export EMAIL

(envsubst < templates/config.yml) > config.yml
(envsubst < templates/observe.yml) > observe.yml

(envsubst < templates/docker-compose.yml) > docker-compose.yml
