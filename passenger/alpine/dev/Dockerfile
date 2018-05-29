FROM previousnext/passenger:alpine

RUN apk add -u --no-cache \
      git \
      mysql-dev \
      patch \
      wget

# Skipper
RUN wget -nv http://bins.skpr.io/linux-amd64-latest.tar.gz && \
    tar -zxf linux-amd64-latest.tar.gz -C /usr/local/bin/ && \
    rm -rf linux-amd64-latest.tar.gz

# M8s
RUN curl -LSs https://github.com/previousnext/m8s/releases/download/v0.7.0/m8s_linux_amd64 -o /usr/local/bin/m8s && \
    chmod a+x /usr/local/bin/m8s

# Github deploy status
RUN curl -LSs https://github.com/previousnext/go-deploy-status/releases/download/1.0.0-alpha2/deploy-status_linux_amd64-1.0.0-alpha2 -o /usr/local/bin/deploy-status && \
    chmod a+x /usr/local/bin/deploy-status

# Hub
RUN cd /tmp && curl -LSs -O https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz && \
    tar -zxf hub-linux-amd64-2.2.9.tgz && \
    mv hub-linux-amd64-2.2.9/bin/hub /usr/local/bin/ && \
    chmod +x /usr/local/bin/hub && \
    rm -rf /tmp/hub-linux-amd64-2.2.9

# Notify - https://github.com/previousnext/notify
RUN curl -LSs https://github.com/previousnext/notify/releases/download/2.1.0/notify_linux_amd64 -o /usr/local/bin/notify && \
    chmod +rx /usr/local/bin/notify

# MicroCron - https://github.com/previousnext/microcron
RUN curl -LSs https://github.com/previousnext/microcron/releases/download/v0.0.1/microcron_linux_amd64 -o /usr/local/bin/microcron && \
    chmod +rx /usr/local/bin/microcron
