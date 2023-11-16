#!/bin/bash

apt update
apt upgrade

wget -O get-docker.sh https://get.docker.com

sh get-docker.sh
rm get-docker.sh

sh nginx/install.sh
