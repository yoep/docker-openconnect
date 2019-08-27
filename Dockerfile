FROM debian:buster-slim

RUN apt-get update && apt-get install -y openconnect ocproxy curl lsof procps && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*

COPY vpn-open vpn-close /usr/bin/
RUN chmod +x /usr/bin/vpn-open & chmod +x /usr/bin/vpn-close
