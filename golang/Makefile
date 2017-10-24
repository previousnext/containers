#!/usr/bin/make -f

IMAGE=previousnext/golang
VERSION=1.8

default: build push

build:
	docker build -t $(IMAGE):latest -t $(IMAGE):$(VERSION) .

push:
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(VERSION)
