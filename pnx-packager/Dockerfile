FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y \
      git \
      curl \
      make \
      virtualenv \
      python-pip && \
    rm -rf /var/cache/apt/*

# Docker client.
RUN curl -Ls -o /tmp/docker-17.09.0-ce.tgz https://download.docker.com/linux/static/stable/x86_64/docker-17.09.0-ce.tgz && \
	  tar -xz -C /tmp -f /tmp/docker-17.09.0-ce.tgz && \
    mv /tmp/docker/* /usr/local/bin && \
    rm -rf /tmp/docker

# Skipper binaries.
RUN curl -Ls -o /tmp/skpr-linux-amd64-latest.tar.gz http://bins.skpr.io/linux-amd64-latest.tar.gz && \
    tar -zxf /tmp/skpr-linux-amd64-latest.tar.gz -C /usr/local/bin/ && \
    rm -rf /tmp/*

# Notify - https://github.com/previousnext/notify
RUN curl -Ls https://github.com/previousnext/notify/releases/download/2.1.0/notify_linux_amd64 -o /usr/local/bin/notify && \
      chmod +rx /usr/local/bin/notify

# Install aws utilities.
RUN virtualenv --python=python3 /usr/local/share/virtualenv
RUN echo ". /usr/local/share/virtualenv/bin/activate" >> /root/.bashrc
RUN pip install awscli
