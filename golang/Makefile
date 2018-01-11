#!/usr/bin/make -f

IMAGE=previousnext/golang
GO_VERSION=1.8

default: build push

build:
	docker build --build-arg GO_VERSION=$(GO_VERSION) -t $(IMAGE):$(GO_VERSION) .

push:
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(GO_VERSION)
