#!/bin/bash

read -p "Username: " USER_NAME && export USER_NAME
read -p "Display name: " DISPLAY_NAME && export DISPLAY_NAME

read -p "E-Mail: " E_MAIL && export E_MAIL
read -s -p "Password: " PASSWORD && export PASSWORD

echo # Do not print % after silent read

(envsubst < templates/user_template.yml) >> config/users_database.yml
