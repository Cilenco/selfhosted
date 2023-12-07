#!/bin/bash

rm -rf config
mkdir config

read -p "Enter domain: " DOMAIN && export DOMAIN

PROXY_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx-proxy)

export PROXY_IP

(envsubst < templates/docker-compose.yml) > docker-compose.yml
(envsubst < templates/configuration.yml) > config/configuration.yml
