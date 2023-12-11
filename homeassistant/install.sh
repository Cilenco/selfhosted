#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit
fi

rm -rf config
mkdir config

read -p "Enter domain: " DOMAIN && export DOMAIN

echo "net.ipv4.conf.all.forwarding=1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6=0" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding=1" >> /etc/sysctl.conf

PROXY_IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' nginx-proxy)

export PROXY_IP

(envsubst < templates/docker-compose.yml) > docker-compose.yml
(envsubst < templates/configuration.yml) > config/configuration.yml
