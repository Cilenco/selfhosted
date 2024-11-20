#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit
fi

CONFIG_FILE=/etc/selfhosted.env

rm -rf $CONFIG_FILE

echo -e "Setting up your computer for selfhosting\n\n"

read -p "Enter domain: " DOMAIN && export DOMAIN

read -p "Enter Ionos API prefix: " IONOS_PREFIX && export IONOS_PREFIX
read -p "Enter Ionos API secret: " IONOS_SECRET && export IONOS_SECRET

read -p "Enter MyFritz Url: " MY_FRITZ_URL && export MY_FRITZ_URL

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

echo -e "\n\nSetup process of your computer finished successfully."
echo -e "Please restart the device now to apply all changes.\n\n"

read -r -p "Would you like to restart the device now? [Y/n] " reboot;

if [ "$reboot" != "" ]; then :; fi
if [ "$reboot" = "${reboot#[Nn]}" ]; then
  shutdown -r now
fi
