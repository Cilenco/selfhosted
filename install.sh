#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit
fi

echo "Installing system updates as well as podman and make"
sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq update
sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq upgrade

sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq install make podman

read -p "Enter domain: " DOMAIN
echo $DOMAIN >> /etc/selfhosted.env

read -p "Enter Ionos API prefix: " IONOS_PREFIX
read -p "Enter Ionos API secret: " IONOS_SECRET

podman secret create --env=true ionos_prefix IONOS_PREFIX
podman secret create --env=true ionos_secret IONOS_SECRET

read -p "Enter SMTP server: " SMTP_SERVER
read -p "Enter SMTP port: " SMTP_PORT

echo $SMTP_SERVER >> /etc/selfhosted.env
echo $SMTP_PORT >> /etc/selfhosted.env

read    -p "Enter SMTP username: " SMTP_USERNAME
read -s -p "Enter SMTP password: " SMTP_PASSWORD

podman secret create --env=true smtp_username SMTP_USERNAME
podman secret create --env=true smtp_password SMTP_PASSWORD
