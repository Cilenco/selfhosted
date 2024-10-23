#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit
fi

CONFIG_FILE=/etc/selfhosted.env

rm -rf $CONFIG_FILE

read -p "Enter domain: " DOMAIN
read -p "Enter E-Mail: " E_MAIL

echo $DOMAIN >> $CONFIG_FILE
echo $E_MAIL >> $CONFIG_FILE

read -p "Enter Ionos API prefix: " IONOS_PREFIX
read -p "Enter Ionos API secret: " IONOS_SECRET

echo "IONOS_PREFIX=$IONOS_PREFIX" >> $CONFIG_FILE
echo "IONOS_SECRET=$IONOS_SECRET" >> $CONFIG_FILE

read -p "Enter SMTP server: " SMTP_SERVER
read -p "Enter SMTP port: " SMTP_PORT

echo "SMTP_SERVER=$SMTP_SERVER" >> $CONFIG_FILE
echo "SMTP_PORT=$SMTP_PORT" >> $CONFIG_FILE

read    -p "Enter SMTP username: " SMTP_USERNAME
read -s -p "Enter SMTP password: " SMTP_PASSWORD

echo "SMTP_USERNAME=$SMTP_USERNAME" >> $CONFIG_FILE
echo "SMTP_PASSWORD=$SMTP_PASSWORD" >> $CONFIG_FILE

if ! [ -x "$(command -v docker)" ]; then
  echo "Downloading and installing docker"
  wget -O get-docker.sh https://get.docker.com

  sh get-docker.sh > /dev/null
  rm get-docker.sh > /dev/null
fi

chown docker:docker $CONFIG_FILE

#  echo "Disabling IPv6 Privacy Extension for a static IPv6 address"
#
#  echo "net.ipv6.conf.all.use_tempaddr=0" >> /etc/sysctl.conf
#  echo "net.ipv6.conf.default.use_tempaddr=0" >> /etc/sysctl.conf

echo -e "Setup process of your computer finished successfully."
echo -e "Please restart the device now to apply all changes.\n"

read -r -p "Would you like to restart the device now? [Y/n] " reboot;

if [ "$reboot" != "" ]; then echo; fi
if [ "$reboot" = "${reboot#[Nn]}" ]; then
  shutdown -r now
fi
