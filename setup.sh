#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit
fi

CONFIG_FILE=/etc/selfhosted.env

rm -rf $CONFIG_FILE

echo -e "Setting up your computer for selfhosting\n\n"

read -p "Enter domain: " DOMAIN
read -p "Enter E-Mail: " E_MAIL

echo "DOMAIN=$DOMAIN" >> $CONFIG_FILE
echo "EMAIL=$E_MAIL" >> $CONFIG_FILE

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

chown root:root $CONFIG_FILE
chmod 660 $CONFIG_FILE

echo -e "\n\n"

########################
########################

read -r -p "Would you like to install docker? [Y/n] " INSTALL_DOCKER;

if [ "$INSTALL_DOCKER" != "" ]; then :; fi
if [ "$INSTALL_DOCKER" = "${INSTALL_DOCKER#[Nn]}" ]; then
  if ! [ -x "$(command -v docker)" ]; then
    echo -e "\nDownloading and installing docker"
    wget -O get-docker.sh https://get.docker.com > /dev/null

    sh get-docker.sh > /dev/null
    rm get-docker.sh > /dev/null
  fi
fi

########################
########################

read -r -p "Would you like to setup docker userns-remap? [Y/n] " DOCKER_REMAP;

if [ "$DOCKER_REMAP" != "" ]; then :; fi
if [ "$DOCKER_REMAP" = "${DOCKER_REMAP#[Nn]}" ]; then
  if ! id -u selfhost >/dev/null 2>&1; then
    useradd --no-create-home selfhost
  fi

  echo "{ \"userns-remap\": \"selfhost\" }" > /etc/docker/daemon.json
fi

########################
########################

read -r -p "Would you like to setup a static IPv6 address? [Y/n] " SETUP_IP6;

if [ "$SETUP_IP6" != "" ]; then :; fi
if [ "$SETUP_IP6" = "${SETUP_IP6#[Nn]}" ]; then
  echo "net.ipv6.conf.all.use_tempaddr=0" >> /etc/sysctl.conf
  echo "net.ipv6.conf.default.use_tempaddr=0" >> /etc/sysctl.conf
fi

########################
########################

echo -e "\n\nSetup process of your computer finished successfully."
echo -e "Please restart the device now to apply all changes.\n\n"

read -r -p "Would you like to restart the device now? [Y/n] " reboot;

if [ "$reboot" != "" ]; then :; fi
if [ "$reboot" = "${reboot#[Nn]}" ]; then
  shutdown -r now
fi
