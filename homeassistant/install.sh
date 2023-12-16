#!/bin/bash

rm -rf config
rm -rf matter
rm -rf thread

mkdir config
mkdir matter
mkdir thread

read -p "Enter domain: " DOMAIN && export DOMAIN

PROXY_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx-proxy)

export PROXY_IP

(envsubst < templates/docker-compose.yml) > docker-compose.yml
(envsubst < templates/configuration.yml) > config/configuration.yml

echo "Finished setup. Please execute 'sudo modprobe ip6table_filter' now"
