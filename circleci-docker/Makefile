#!/usr/bin/make -f

IMAGE=previousnext/circleci-docker
VERSION=$(shell git describe --tag --always)

default: build push

build:
	docker build -t $(IMAGE):latest -t $(IMAGE):$(VERSION) .

push:
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(VERSION)
