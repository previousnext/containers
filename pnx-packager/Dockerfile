FROM debian:stable-slim

# Install required apt packages.
RUN apt-get update && apt-get install -y git curl build-essential && rm -rf /var/cache/apt/*

# Install docker client.
RUN curl -Ls -o /tmp/docker.tgz https://download.docker.com/linux/static/edge/x86_64/docker-17.10.0-ce.tgz && \
	  tar -xz -C /tmp -f /tmp/docker.tgz && \
    mv /tmp/docker/* /usr/local/bin && \
    rm -rf /tmp/docker

# Install skpr client.
RUN curl -Ls -o /tmp/skpr-linux-amd64-latest.tar.gz http://bins.skpr.io/linux-amd64-latest.tar.gz && \
    tar -zxf /tmp/skpr-linux-amd64-latest.tar.gz -C /usr/local/bin/ && \
    rm -rf /tmp/*
