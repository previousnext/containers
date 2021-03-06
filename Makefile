#!/usr/bin/make -f

IMAGE=previousnext/container-builder
VERSION=latest

# Build and tests
build:
	docker build -t $(IMAGE):$(VERSION) .

# Build and release
release: build
	docker push $(IMAGE):$(VERSION)

.PHONY: build release