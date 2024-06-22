#!/bin/bash

read -p "Username: " USER_NAME && export USER_NAME
read -p "Display name: " DISPLAY_NAME && export DISPLAY_NAME

read -p "E-Mail: " E_MAIL && export E_MAIL
read -s -p "Password: " PW

echo # Do not print % after silent read
SALT=$(openssl rand -hex 16)

export PASSWORD=$(echo -n $PW | argon2 $SALT -id -t 1 -l 32 -m 10 -p 8 -e)
(envsubst < templates/user_template.yml) >> config/users_database.yml
