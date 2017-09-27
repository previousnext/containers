#!/usr/bin/make -f

IMAGE=previousnext/grafana
VERSION=$(shell git rev-parse --short HEAD)

default: build push

build:
	docker build -t $(IMAGE):latest -t $(IMAGE):$(VERSION) .

push:
	docker push $(IMAGE):latest
	docker push $(IMAGE):$(VERSION)
