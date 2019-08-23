FROM debian:buster-slim

RUN apt-get update && apt-get install -y openconnect ocproxy curl lsof procps && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*

COPY ./vpn_open /usr/bin/vpn_open
RUN chmod +x /usr/bin/vpn_open

COPY ./vpn_close /usr/bin/vpn_close
RUN chmod +x /usr/bin/vpn_close
