#!/bin/bash

export IONOS_PREFIX=$(cat /run/secrets/ionos_prefix)
export IONOS_SECRET=$(cat /run/secrets/ionos_secret)

acme.sh --issue --dns dns_ionos -d ${DOMAIN} -d *.${DOMAIN}

acme.sh --install-cert -d ${DOMAIN} -d *.${DOMAIN}    \
        --key-file        /nginx/certs/${DOMAIN}.crt  \
        --cert-file       /nginx/certs/${DOMAIN}.key  \
        --reloadcmd       "nginx -s reload"

nginx -g daemon off
