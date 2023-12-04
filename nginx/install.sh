#!/bin/bash

docker volume create certs

read -p "Enter Domain: " DOMAIN && export DOMAIN
read -p "Enter E-Mail address: " EMAIL && export EMAIL

read -p "Enter Ionos API prefix: " PREFIX
read -p "Enter Ionos API secret: " SECRET

echo "$PREFIX.$SECRET" > credentials

(envsubst < templates/docker-compose.yml) > docker-compose.yml
