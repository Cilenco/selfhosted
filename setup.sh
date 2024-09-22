#!/bin/bash

#if [[ $EUID > 0 ]]; then
#  echo "Please run as root"
#  exit
#fi

CONFIG_FILE=$HOME/config.ini

echo "Installing system updates as well as make and crudini"
sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq update
sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq upgrade

sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq install make
sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq install crudini

read -p "Enter domain: " DOMAIN
read -p "Enter E-Mail: " EMAIL

crudini --set $CONFIG_FILE general domain $DOMAIN
crudini --set $CONFIG_FILE general email $EMAIL

read -p "Enter Ionos API prefix: " PREFIX
read -p "Enter Ionos API secret: " SECRET

crudini --set $CONFIG_FILE ionos prefix $PREFIX
crudini --set $CONFIG_FILE ionos secret $SECRET

read -p "Enter SMTP server: " SMTP_SERVER
read -p "Enter SMTP port: " SMTP_PORT

read    -p "Enter SMTP username: " SMTP_USERNAME
read -s -p "Enter SMTP password: " SMTP_PASSWORD

crudini --set $CONFIG_FILE smtp server $SMTP_SERVER
crudini --set $CONFIG_FILE smtp port $SMTP_PORT

crudini --set $CONFIG_FILE smtp username $SMTP_USERNAME
crudini --set $CONFIG_FILE smtp password $SMTP_PASSWORD

echo "Downloading and installing docker"
wget -O get-docker.sh https://get.docker.com

sh get-docker.sh > /dev/null
rm get-docker.sh > /dev/null

[ $(getent group docker) ] || sudo groupadd docker
sudo usermod -aG docker ${SUDO_USER:-$USER}

#if [[ 0 > 0 ]]; then
#  groupadd docker
#  usermod -aG docker admin

#  echo "Disabling IPv6 Privacy Extension for a static IPv6 address"
#
#  echo "net.ipv6.conf.all.use_tempaddr=0" >> /etc/sysctl.conf
#  echo "net.ipv6.conf.default.use_tempaddr=0" >> /etc/sysctl.conf
#
#  echo -e "Setup process of your Raspberry finished successfully."
#  echo -e "Please restart the device now to apply all changes.\n"
#
#  read -r -p "Would you like to restart the device now? [Y/n] " reboot;
#
#  if [ "$reboot" != "" ]; then echo; fi
#  if [ "$reboot" = "${reboot#[Nn]}" ]; then
#    shutdown -r now
#  fi
#fi
