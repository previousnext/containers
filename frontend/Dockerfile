ARG NODE_VERSION=8

FROM node:${NODE_VERSION}-alpine

ENV PATH "$PATH:/data/node_modules/.bin"

RUN apk add --no-cache -u \
    bash \
    bash-completion \
    curl \
    make \
    python2
