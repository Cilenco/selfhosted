#!/bin/bash

#if [[ $EUID > 0 ]]; then
#  echo "Please run as root"
#  exit
#fi

#apt install podman    # Install container runtime
#apt install bzip2     # Used by autorestic install

# Install restic and autorestic for backing up all data
#wget -qO - https://raw.githubusercontent.com/cupcakearmy/autorestic/master/install.sh | bash

# Gather general information for
echo -e "Setting up your machine for selfhosting\n\n"

read -p "Enter domain: " DOMAIN
read -p "Enter E-Mail: " E_MAIL

read -p "Enter Ionos API prefix: " IONOS_PREFIX
read -p "Enter Ionos API secret: " IONOS_SECRET

read -p "Enter SMTP host: " SMTP_HOST
read -p "Enter SMTP port: " SMTP_PORT

read    -p "Enter SMTP username: " SMTP_USERNAME
read -s -p "Enter SMTP password: " SMTP_PASSWORD

# Create podman secrets
printf $E_MAIL | podman secret create E_MAIL -

printf $IONOS_PREFIX | podman secret create IONOS_PREFIX -
printf $IONOS_SECRET | podman secret create IONOS_SECRET -

printf $SMTP_HOST | podman secret create SMTP_HOST -
printf $SMTP_PORT | podman secret create SMTP_PORT -

printf $SMTP_USERNAME | podman secret create SMTP_USERNAME -
printf $SMTP_PASSWORD | podman secret create SMTP_PASSWORD -

# Add default config for containers
CONF_DIR=~/.config/containers/systemd
mkdir -p $CONF_DIR/container.d

ln -sf $PWD/config/container.conf $CONF_DIR/container.d
ln -sf $PWD/config/shared.env $CONF_DIR/shared.env

# Allow unprivileged port binding
#UNPRIVILEGED_PORT_FILE=/etc/sysctl.d/10-unprivileged-port.conf

#if [ ! -f $UNPRIVILEGED_PORT_FILE ]; then
#  echo "net.ipv4.ip_unprivileged_port_start=53" >> $UNPRIVILEGED_PORT_FILE
#fi
