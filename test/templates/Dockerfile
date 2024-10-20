FROM nginxinc/nginx-unprivileged:stable-alpine-slim

ENV DOMAIN=
ENV EMAIL=

USER root

# Install dependencies used by acmes.sh
RUN apk add --no-cache -f openssl socat

RUN apk add --no-cache --virtual .acme git && mkdir acme

RUN git clone --depth 1 https://github.com/acmesh-official/acme.sh.git
RUN cd acme.sh && ./acme.sh --install --home /acme --email ${EMAIL}

RUN rm -rf acme.sh
RUN apk del .acme

#RUN acme.sh --issue --dns dns_ionos \
#    -d ${DOMAIN} -d *.${DOMAIN} -m ${EMAIL} \
#    --reloadcmd "nginx -s reload"

USER nginx
