ARG ALPINE_VERSION=3.8

FROM alpine:${ALPINE_VERSION}

ENV PATH "$PATH:/data/node_modules/.bin"

RUN apk add --no-cache -u \
    bash \
    bash-completion \
    curl \
    make \
    g++ \
    jq \
    libffi-dev \
    nodejs \
    npm \
    python2 \
    yarn
