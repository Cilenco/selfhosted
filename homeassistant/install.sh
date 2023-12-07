#!/bin/bash

rm -rf config
mkdir config

read -p "Enter domain: " DOMAIN && export DOMAIN

(envsubst < templates/docker-compose.yml) > docker-compose.yml
(envsubst < templates/configuration.yml) > config/configuration.yml
