FROM caddy:builder AS builder
RUN xcaddy build --with github.com/caddy-dns/ionos

FROM caddy:latest
COPY --from=builder /usr/bin/caddy /usr/bin/caddy

RUN adduser --system --no-create-home caddy

RUN mkdir /certs
CHOWN caddy /certs
