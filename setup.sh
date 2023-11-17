#!/bin/bash

if [[ $EUID > 0 ]]; then
  echo "Please run as root"
  exit
fi

echo "Setting up your RaspberryPi, this may take a while..."

echo "Updating system"
apt update > /dev/null
apt upgrade > /dev/null

echo "Downloading and installing docker"
wget -O get-docker.sh https://get.docker.com

sh get-docker.sh > /dev/null
rm get-docker.sh > /dev/null

echo "Disabling IPv6 Privacy Extension for a static IPv6 address"

echo "net.ipv6.conf.all.use_tempaddr=0" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.use_tempaddr=0" >> /etc/sysctl.conf
