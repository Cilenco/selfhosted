#!/bin/bash


########################
########################

read -p "Enter domain: " DOMAIN
read -p "Enter E-Mail: " E_MAIL

printf $DOMAIN | podman secret create DOMAIN - >/dev/null
printf $E_MAIL | podman secret create E_MAIL - >/dev/null

read -p "Enter Ionos API prefix: " IONOS_PREFIX
read -p "Enter Ionos API secret: " IONOS_SECRET

printf $IONOS_PREFIX | podman secret create IONOS_PREFIX - >/dev/null
printf $IONOS_SECRET | podman secret create IONOS_SECRET - >/dev/null

read -p "Enter SMTP host: " SMTP_HOST
read -p "Enter SMTP port: " SMTP_PORT

printf $SMTP_HOST | podman secret create SMTP_HOST - >/dev/null
printf $SMTP_PORT | podman secret create SMTP_PORT - >/dev/null

read    -p "Enter SMTP username: " SMTP_USERNAME
read -s -p "Enter SMTP password: " SMTP_PASSWORD

printf $SMTP_USERNAME | podman secret create SMTP_USERNAME - >/dev/null
printf $SMTP_PASSWORD | podman secret create SMTP_PASSWORD - >/dev/null

########################
########################
printf $(openssl rand -hex    64) | podman secret create ACTUAL_BUDGET_CLIENT_SECRET - >/dev/null

printf $(openssl rand -hex    64) | podman secret create NEXTCLOUD_CLIENT_SECRET - >/dev/null
printf $(openssl rand -hex    12) | podman secret create NEXTCLOUD_DB_USERNAME   - >/dev/null
printf $(openssl rand -base64 24) | podman secret create NEXTCLOUD_DB_PASSWORD   - >/dev/null

printf $(openssl rand -hex    32) | podman secret create OUTLINE_SECRET_KEY    - >/dev/null
printf $(openssl rand -hex    64) | podman secret create OUTLINE_CLIENT_SECRET - >/dev/null
printf $(openssl rand -hex    32) | podman secret create OUTLINE_UTILS_SECRET  - >/dev/null
printf $(openssl rand -hex    12) | podman secret create OUTLINE_DB_USERNAME   - >/dev/null
printf $(openssl rand -base64 24) | podman secret create OUTLINE_DB_PASSWORD   - >/dev/null

printf $(openssl rand -hex    64) | podman secret create AUTHELIA_JWT_SECRET             - >/dev/null
printf $(openssl rand -hex    64) | podman secret create AUTHELIA_OIDC_HMAC_SECRET       - >/dev/null
printf $(openssl rand -hex    64) | podman secret create AUTHELIA_STORAGE_ENCRYPTION_KEY - >/dev/null
printf $(openssl rand -hex    64) | podman secret create AUTHELIA_SESSION_SECRET         - >/dev/null

printf $(openssl rand -hex    64) | podman secret create LDAP_JWT_KEY  - >/dev/null
printf $(openssl rand -hex    64) | podman secret create LDAP_KEY_SEED - >/dev/null
printf $(openssl rand -hex    12) | podman secret create LDAP_USERNAME - >/dev/null
printf $(openssl rand -base64 24) | podman secret create LDAP_PASSWORD - >/dev/null

echo -e "\n\n"

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

echo -e "\n\nSetup process of your machine finished successfully."
echo -e "Please restart the machine now to apply all changes.\n\n"

read -r -p "Would you like to restart the machine now? [Y/n] " reboot;

if [ "$reboot" != "" ]; then :; fi
if [ "$reboot" = "${reboot#[Nn]}" ]; then
  shutdown -r now
fi
