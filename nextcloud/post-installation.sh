#!/bin/bash

#################################################
# Setup basic config                            #
#################################################

php occ config:system:set trusted_domains 2 --type="string" --value="cloud.$DOMAIN"

php occ config:system:set default_language --type="string" --value="de"
php occ config:system:set default_phone_region --type="string" --value="DE"
php occ config:system:set default_locale --type="string" --value="de_DE"

php occ config:system:set default_timezone --type="string" --value="Europe/Berlin"

php occ config:system:set hide_login_form --type="boolean" --value="false"
php occ config:system:set updatechecker --type="boolean" --value="false"

php occ config:system:set defaultapp --type="string" --value="files"

#"files.chunked_upload.max_size" => 4 * 1024 * 1024 * 1024, // 4 GB

#################################################
# Configure additional apps                     #
#################################################

php occ app:install calendar
php occ app:install contacts
php occ app:install user_oidc

php occ app:install unroundedcorners

php occ app:disable dashboard
php occ app:disable weather_status
php occ app:disable user_status

#################################################
# Setup Authelia authentication                 #
#################################################

php occ user_oidc:provider authelia \
    --clientid="nextcloud" --clientsecret=$CLIENT_SECRET \
    --discoveryuri="https://auth.$DOMAIN/.well-known/openid-configuration
