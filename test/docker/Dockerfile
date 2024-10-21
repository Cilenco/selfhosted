FROM nginxinc/nginx-unprivileged:stable-alpine-slim

ENV IONOS_PREFIX=
ENV IONOS_SECRET=

ENV DOMAIN=
ENV MAIL=

USER root

# Install dependencies used by acmes.sh
RUN apk add --no-cache -f openssl socat

RUN apk add --no-cache --virtual .acme git && mkdir acme

RUN git clone --depth 1 https://github.com/acmesh-official/acme.sh.git
RUN cd acme.sh && ./acme.sh --install --home /acme --email ${EMAIL}

RUN rm -rf acme.sh
RUN apk del .acme

RUN mkdir certs && chown nginx acme
RUN cd certs && touch ${DOMAIN}.crt ${DOMAIN}.key

RUN chown nginx /certs/${DOMAIN}.crt
RUN chown nginx /certs/${DOMAIN}.key

USER nginx

RUN acme.sh --issue \
    --dns dns_ionos \
    -d ${DOMAIN} \
    -d *.${DOMAIN}

RUN acme.sh --install-cert            \
    --domain    ${DOMAIN}             \
    --key-file  /certs/${DOMAIN}.crt  \
    --cert-file /certs/${DOMAIN}.key  \
    --reloadcmd "nginx -s reload"
