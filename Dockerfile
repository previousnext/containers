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

# Linting.
RUN curl -Ls -o /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.10.4/hadolint-Linux-x86_64 && \
    chmod +x /usr/local/bin/hadolint

# Testing.
RUN curl -LO https://storage.googleapis.com/container-structure-test/v1.4.0/container-structure-test-linux-amd64 && \
    mv container-structure-test-linux-amd64 container-structure-test && \
    chmod +x container-structure-test && \
    sudo mv container-structure-test /usr/local/bin/
