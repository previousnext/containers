FROM debian:stable-slim

RUN apt-get update && apt-get install -y git curl make && rm -rf /var/cache/apt/*
RUN curl -Ls -o /tmp/docker-17.09.0-ce.tgz https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz && \
	  tar -xz -C /tmp -f /tmp/docker-17.09.0-ce.tgz && \
    mv /tmp/docker/* /usr/local/bin && \
    rm -rf /tmp/docker
RUN curl -Ls -o /tmp/skpr-linux-amd64-latest.tar.gz http://bins.skpr.io/linux-amd64-latest.tar.gz && \
    tar -zxf /tmp/skpr-linux-amd64-latest.tar.gz -C /usr/local/bin/ && \
    rm -rf /tmp/*
