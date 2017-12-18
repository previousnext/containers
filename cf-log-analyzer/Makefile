#!/usr/bin/make -f

IMAGE=previousnext/cf-log-analyzer
VERSION=$(shell git describe --tag --always)
BUILD_ARGS="--compress"

default: build push

build:
	docker build ${BUILD_ARGS} -t $(IMAGE):latest -t $(IMAGE):$(VERSION) .

push:
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(VERSION)

.PHONY: default build push
