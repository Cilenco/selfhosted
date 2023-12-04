#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit
fi

echo "Setting up your RaspberryPi, this may take a while..."

echo "Downloading and installing docker"
wget -O get-docker.sh https://get.docker.com

sh get-docker.sh > /dev/null
rm get-docker.sh > /dev/null

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
