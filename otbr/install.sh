#!/bin/bash

read -p "Enter domain: " DOMAIN && export DOMAIN

(envsubst < templates/docker-compose.yml) > docker-compose.yml
echo "Finished setup. Please execute 'sudo modprobe ip6table_filter' now"
