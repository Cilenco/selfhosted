#!/bin/bash

# Start nginx server
nginx -g daemon

/acme/acme.sh --issue                         \
              --dns dns_ionos                 \
              --server letsencrypt            \
              --domain *.$DOMAIN              \
              --domain $DOMAIN

/acme/acme.sh --install-cert                  \
              --domain    $DOMAIN             \
              --key-file  /certs/$DOMAIN.crt  \
              --cert-file /certs/$DOMAIN.key  \
              --reloadcmd "nginx -s reload"
