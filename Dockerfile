FROM debian:buster-slim

RUN apt-get update && apt-get install -y openconnect ocproxy curl lsof procps && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*

COPY ./vpn-open /usr/bin/vpn-open
RUN chmod +x /usr/bin/vpn-open

COPY ./vpn-close /usr/bin/vpn-close
RUN chmod +x /usr/bin/vpn-close
