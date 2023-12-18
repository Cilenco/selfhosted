#!/bin/bash

docker network create -d macvlan --ipv6 --subnet=192.168.178.0/24 --gateway=192.168.178.1 --subnet=fd00:4a82:739b::/64 --gateway=fd00:4a82:739b::ca0e:14ff:fe8d:8d84 -o parent=eth0 home_network

read -p "Enter domain: " DOMAIN && export DOMAIN

(envsubst < templates/docker-compose.yml) > docker-compose.yml
echo "Finished setup. Please execute 'sudo modprobe ip6table_filter' now"
