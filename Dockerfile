FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y openconnect netcat-traditional ocproxy dnsutils telnet unbound gettext && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*
