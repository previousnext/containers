FROM previousnext/apache2-alpine:1.x

# hadolint ignore=DL3018
RUN apk add --update --no-cache \
   git \
   nodejs \
   npm \
   openssh-client \
   yarn

# Skipper
RUN curl -sLO http://bins.skpr.io/linux-amd64-latest.tar.gz && \
    tar -zxf linux-amd64-latest.tar.gz -C /usr/local/bin/ && \
    rm -rf linux-amd64-latest.tar.gz

# M8s
RUN curl -sL https://github.com/previousnext/m8s/releases/download/v0.8.0/m8s_linux_amd64 -o /usr/local/bin/m8s && \
    chmod a+x /usr/local/bin/m8s

# Github deploy status
RUN curl -sL https://github.com/previousnext/go-deploy-status/releases/download/1.0.0-alpha3/deploy-status_linux_amd64 -o /usr/local/bin/deploy-status && \
    chmod a+x /usr/local/bin/deploy-status

# Hub
RUN curl -sL http://bins.skpr.io/hub-latest -o /usr/local/bin/hub && \
      chmod +rx /usr/local/bin/hub

# Notify - https://github.com/previousnext/notify
RUN curl -sL https://github.com/previousnext/notify/releases/download/2.1.0/notify_linux_amd64 -o /usr/local/bin/notify && \
    chmod +rx /usr/local/bin/notify

# Semantic - https://github.com/nickschuch/semantic
RUN curl -sL https://github.com/nickschuch/semantic/releases/download/0.0.2/semantic-linux-amd64 -o /usr/local/bin/semantic && \
    chmod +rx /usr/local/bin/semantic
