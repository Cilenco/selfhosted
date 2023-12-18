#!/bin/bash

read -p "Enter domain: " DOMAIN && export DOMAIN
(envsubst < templates/docker-compose.yml) > docker-compose.yml
