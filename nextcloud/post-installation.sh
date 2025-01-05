#!/bin/bash

php occ app:install  calendar
php occ app:enable   calendar

php occ app:install  contacts
php occ app:enable   contacts

php occ app:install  user_oidc
php occ app:enable   user_oidc

php occ app:install  unroundedcorners
php occ app:enable   unroundedcorners

php occ app:disable  dashboard
php occ app:disable  weather_status
php occ app:disable  user_status

php occ user_oidc:provider authelia \
    --clientid="nextcloud" --clientsecret=$CLIENT_SECRET \
    --discoveryuri="http://authelia/openid-configuration"
