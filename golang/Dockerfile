ARG GO_VERSION=1.13
FROM golang:${GO_VERSION}

RUN go get github.com/tcnksm/ghr && \
    go get github.com/mitchellh/gox && \
    go get github.com/jstemmer/go-junit-report && \
    go get golang.org/x/lint/golint
