FROM nginxinc/nginx-unprivileged:stable-alpine-slim

ARG DOMAIN
ARG EMAIL

ENV DOMAIN $DOMAIN
ENV EMAIL $EMAIL

USER root

COPY entrypoint.sh /entrypoint.sh

# Install dependencies used by acmes.sh
RUN apk add --no-cache -f openssl curl socat

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

ENTRYPOINT [ "sh", "/entrypoint.sh" ]
