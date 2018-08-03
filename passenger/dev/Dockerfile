FROM  previousnext/passenger:base
LABEL maintainer="admin@previousnext.com.au"

ENV HUB_VERSION  2.2.9
ENV HUB_NAME     hub-linux-amd64-$HUB_VERSION

RUN apt-get update && \
    apt-get install -y \
      bash-completion \
      vim \
      wget && \
    rm -rf /var/lib/apt/lists/*

RUN echo '[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
              . /usr/share/bash-completion/bash_completion' >> ~/.bashrc

# Skipper CLI toolkit.
RUN wget http://bins.skpr.io/linux-amd64-latest.tar.gz && \
      tar -zxf linux-amd64-latest.tar.gz -C /usr/local/bin/ && \
      rm -rf linux-amd64-latest.tar.gz

# Temporary environment builder.
RUN curl -L https://s3.amazonaws.com/pnx-bins/m8s-cli-0.2.1_linux_amd64 -o /usr/local/bin/m8s && \
      chmod a+x /usr/local/bin/m8s

# Github deploy status
RUN curl -L https://github.com/previousnext/go-deploy-status/releases/download/1.0.0-alpha3/deploy-status_linux_amd64 -o /usr/local/bin/deploy-status && \
      chmod a+x /usr/local/bin/deploy-status

# Skipper v2 CLI toolkit.
RUN curl -L https://s3-ap-southeast-2.amazonaws.com/bins.skpr.io/2.0.0/skpr-linux -o /usr/local/bin/skpr2 && \
      chmod +rx /usr/local/bin/skpr2

# Github Hub
RUN cd /tmp && curl -L -O https://github.com/github/hub/releases/download/v$HUB_VERSION/$HUB_NAME.tgz && \
      tar -zxf $HUB_NAME.tgz && \
      mv $HUB_NAME/bin/hub /usr/local/bin/ && \
      chmod +x /usr/local/bin/hub && \
      rm -rf /tmp/$HUB_NAME

# gosu
RUN curl -L https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 -o /usr/local/bin/gosu && \
      chmod a+x /usr/local/bin/gosu
