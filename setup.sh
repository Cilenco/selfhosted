#!/bin/bash


########################
########################

read -p "Enter domain: " DOMAIN
read -p "Enter E-Mail: " E_MAIL

printf $DOMAIN | podman secret create DOMAIN -
printf $E_MAIL | podman secret create E_MAIL -

read -p "Enter Ionos API prefix: " IONOS_PREFIX
read -p "Enter Ionos API secret: " IONOS_SECRET

printf $IONOS_PREFIX | podman secret create IONOS_PREFIX -
printf $IONOS_SECRET | podman secret create IONOS_SECRET -

read -p "Enter SMTP host: " SMTP_HOST
read -p "Enter SMTP port: " SMTP_PORT

printf $SMTP_HOST | podman secret create SMTP_HOST -
printf $SMTP_PORT | podman secret create SMTP_PORT -

read    -p "Enter SMTP username: " SMTP_USERNAME
read -s -p "Enter SMTP password: " SMTP_PASSWORD

printf $SMTP_USERNAME | podman secret create SMTP_USERNAME -
printf $SMTP_PASSWORD | podman secret create SMTP_PASSWORD -

########################
########################

printf $(openssl rand -hex 64) | podman secret create NEXTCLOUD_CLIENT_SECRET -

printf $(openssl rand -hex 64) | podman secret create POSTGRES_USERNAME -
printf $(openssl rand -hex 64) | podman secret create POSTGRES_PASSWORD -

printf $(openssl rand -hex 32) | podman secret create OUTLINE_SECRET_KEY -
printf $(openssl rand -hex 64) | podman secret create OUTLINE_CLIENT_SECRET -
printf $(openssl rand -hex 32) | podman secret create OUTLINE_UTILS_SECRET -

printf $(openssl rand -hex 64) | podman secret create AUTHELIA_JWT_SECRET -
printf $(openssl rand -hex 64) | podman secret create AUTHELIA_OIDC_HMAC_SECRET -
printf $(openssl rand -hex 64) | podman secret create AUTHELIA_STORAGE_ENCRYPTION_KEY -
printf $(openssl rand -hex 64) | podman secret create AUTHELIA_SESSION_SECRET -

printf $(openssl rand -hex 64) | podman secret create LDAP_JWT_KEY -
printf $(openssl rand -hex 64) | podman secret create LDAP_KEY_SEED -
printf $(openssl rand -hex 12) | podman secret create LDAP_PASSWORD -
printf $(openssl rand -hex  8) | podman secret create LDAP_USERNAME -

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
