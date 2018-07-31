# Build the command line application.
FROM mhart/alpine-node:6 as cli
ENV VERSION=2.13.0
ADD https://github.com/arachnys/athenapdf/archive/v${VERSION}.tar.gz /tmp/anthenapdf.tar.gz
RUN tar -zxf /tmp/anthenapdf.tar.gz -C /tmp/ && \
    mv /tmp/athenapdf-${VERSION} /tmp/athenapdf
WORKDIR /tmp/athenapdf/cli
RUN npm install
RUN mkdir -p build/artifacts
RUN npm run build:linux

# Build the wrapper web service.
FROM golang:1.10-alpine as service
ENV VERSION=2.13.0
ADD https://github.com/arachnys/athenapdf/archive/v${VERSION}.tar.gz /tmp/anthenapdf.tar.gz
RUN tar -zxf /tmp/anthenapdf.tar.gz -C /tmp/ && \
    mkdir -p /go/src/github.com/arachnys && \
    mv /tmp/athenapdf-${VERSION} /go/src/github.com/arachnys/athenapdf
WORKDIR /go/src/github.com/arachnys/athenapdf/weaver
RUN apk add --update git
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure --vendor-only -v
RUN CGO_ENABLED=0 go build -v -o weaver .

# Build the main container which will have both!
FROM debian:8.7

ENV GIN_MODE="release" \
    WEAVER_AUTH_KEY="CHANGE-ME" \
    WEAVER_ATHENA_CMD="athenapdf -S" \
    WEAVER_MAX_WORKERS="10" \
    WEAVER_MAX_CONVERSION_QUEUE="50" \
    WEAVER_WORKER_TIMEOUT="90" \
    WEAVER_CONVERSION_FALLBACK="false"

RUN echo 'deb http://httpredir.debian.org/debian/ stable main contrib non-free' >> /etc/apt/sources.list

RUN apt-get -yq update && \
    apt-get -yq install \
        wget \
        xvfb \
        libasound2 \
        libgconf-2-4 \
        libgtk2.0-0 \
        libnotify4 \
        libnss3 \
        libxss1 \
        libXtst6 \
        culmus \
        fonts-beng \
        fonts-dejavu \
        fonts-hosny-amiri \
        fonts-lklug-sinhala \
        fonts-lohit-guru \
        fonts-lohit-knda \
        fonts-samyak-gujr \
        fonts-samyak-mlym \
        fonts-samyak-taml \
        fonts-sarai \
        fonts-sil-abyssinica \
        fonts-sil-padauk \
        fonts-telu \
        fonts-thai-tlwg \
        ttf-liberation \
        ttf-unfonts-core \
        ttf-wqy-zenhei && \
    apt-get -yq autoremove && \
    apt-get -yq clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64.deb && \
    dpkg -i dumb-init_*.deb && \
    rm dumb-init_*.deb

COPY fonts.conf /etc/fonts/conf.d/100-athena.conf

ENV PATH /athenapdf/:$PATH
COPY --from=cli /tmp/athenapdf/cli/build/athenapdf-linux-x64 /athenapdf
RUN mkdir -p /converted/

COPY --from=service /go/src/github.com/arachnys/athenapdf/weaver/weaver /usr/local/bin/weaver
RUN chmod +x /usr/local/bin/weaver

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080

CMD ["dumb-init", "weaver"]

ENTRYPOINT ["/entrypoint.sh"]