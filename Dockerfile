FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y git \
                       curl \
                       make && \
    rm -rf /var/cache/apt/*

# Building.
RUN curl -Ls -o /tmp/docker-17.09.0-ce.tgz https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz && \
	  tar -xz -C /tmp -f /tmp/docker-17.09.0-ce.tgz && \
    mv /tmp/docker/* /usr/local/bin && \
    rm -rf /tmp/docker

# Testing.
RUN curl -Ls -o /usr/local/bin/container-structure-test https://storage.googleapis.com/container-structure-test/latest/container-structure-test && \
    chmod +x /usr/local/bin/container-structure-test

# Linting
# @todo, Add linting.