ARG GO_VERSION=1.8
FROM circleci/golang:${GO_VERSION}

RUN go get github.com/tcnksm/ghr && \
    go get github.com/mitchellh/gox && \
    go get github.com/jstemmer/go-junit-report && \
    go get github.com/golang/lint/golint
