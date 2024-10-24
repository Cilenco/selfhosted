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

read -p "Enter SMTP host: " SMTP_HOST
read -p "Enter SMTP port: " SMTP_PORT

echo "SMTP_HOST=$SMTP_HOST" >> $CONFIG_FILE
echo "SMTP_PORT=$SMTP_PORT" >> $CONFIG_FILE

read    -p "Enter SMTP username: " SMTP_USERNAME
read -s -p "Enter SMTP password: " SMTP_PASSWORD

echo "SMTP_USERNAME=$SMTP_USERNAME" >> $CONFIG_FILE
echo "SMTP_PASSWORD=$SMTP_PASSWORD" >> $CONFIG_FILE

#echo "OUTLINE_SECRET_KEY=$(openssl rand -hex 32)" >> $CONFIG_FILE
#echo "OUTLINE_UTILS_SECRET=$(openssl rand -hex 32)" >> $CONFIG_FILE

if ! [ -x "$(command -v docker)" ]; then
  echo -e "\n\nDownloading and installing docker engine"
  wget -O get-docker.sh https://get.docker.com > /dev/null

  sh get-docker.sh > /dev/null
  rm get-docker.sh > /dev/null
fi

if ! id -u selfhost >/dev/null 2>&1; then
    echo 'Creating selfhost user for docker userns-remap (not set)'
    useradd --no-create-home selfhost
fi

chown root:root $CONFIG_FILE
chmod 660 $CONFIG_FILE

#  echo "Disabling IPv6 Privacy Extension for a static IPv6 address"
#
#  echo "net.ipv6.conf.all.use_tempaddr=0" >> /etc/sysctl.conf
#  echo "net.ipv6.conf.default.use_tempaddr=0" >> /etc/sysctl.conf

echo -e "\n\nSetup process of your computer finished successfully."
echo -e "Please restart the device now to apply all changes.\n\n"

read -r -p "Would you like to restart the device now? [Y/n] " reboot;

if [ "$reboot" != "" ]; then echo; fi
if [ "$reboot" = "${reboot#[Nn]}" ]; then
  shutdown -r now
fi
