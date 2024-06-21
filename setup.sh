#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit
fi

CONFIG_FILE=$HOME/config.ini

read -p "Enter domain: " DOMAIN
read -p "Enter E-Mail: " EMAIL

read -p "Enter Ionos API prefix: " PREFIX
read -p "Enter Ionos API secret: " SECRET

crudini --set $CONFIG_FILE general domain $DOMAIN 
crudini --set $CONFIG_FILE general email $EMAIL

crudini --set $CONFIG_FILE ionos prefix $PREFIX
crudini --set $CONFIG_FILE ionos secret $SECRET

echo "Downloading and installing crudini and argon2"
DEBIAN_FRONTEND=noninteractive apt-get -yq update
DEBIAN_FRONTEND=noninteractive apt-get -yq upgrade

DEBIAN_FRONTEND=noninteractive apt-get -yq install make
DEBIAN_FRONTEND=noninteractive apt-get -yq install crudini
DEBIAN_FRONTEND=noninteractive apt-get -yq install argon2

echo "Downloading and installing docker"
wget -O get-docker.sh https://get.docker.com

sh get-docker.sh > /dev/null
rm get-docker.sh > /dev/null

if [[ 0 > 0 ]]; then
  groupadd docker
  usermod -aG docker admin

  echo "Disabling IPv6 Privacy Extension for a static IPv6 address"

  echo "net.ipv6.conf.all.use_tempaddr=0" >> /etc/sysctl.conf
  echo "net.ipv6.conf.default.use_tempaddr=0" >> /etc/sysctl.conf

  echo -e "Setup process of your Raspberry finished successfully."
  echo -e "Please restart the device now to apply all changes.\n"

  read -r -p "Would you like to restart the device now? [Y/n] " reboot; 

  if [ "$reboot" != "" ]; then echo; fi
  if [ "$reboot" = "${reboot#[Nn]}" ]; then
    shutdown -r now
  fi
fi
