FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y openconnect ocproxy curl && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*
