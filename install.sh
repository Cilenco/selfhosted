#!/bin/bash

read -p "Enter domain: " DOMAIN
echo "DOMAIN=$DOMAIN" >> ~/selfhosted.env

read -p "Enter Ionos API prefix: " IONOS_PREFIX
read -p "Enter Ionos API secret: " IONOS_SECRET

printf $IONOS_PREFIX | podman secret create ionos_prefix -
printf $IONOS_SECRET | podman secret create ionos_secret -

read -p "Enter SMTP server: " SMTP_SERVER
read -p "Enter SMTP port: " SMTP_PORT

echo "SMTP_SERVER=$SMTP_SERVER" >> ~/selfhosted.env
echo "SMTP_PORT=$SMTP_PORT" >> ~/selfhosted.env

read    -p "Enter SMTP username: " SMTP_USERNAME
read -s -p "Enter SMTP password: " SMTP_PASSWORD

printf $SMTP_USERNAME | podman secret create smtp_username -
printf $SMTP_PASSWORD | podman secret create smtp_password -
