#!/usr/bin/make -f

IMAGE=previousnext/passenger
VERSION=latest

# Build and tests
build:
	docker build -f base/Dockerfile -t $(IMAGE):base base
	docker build -f prod/Dockerfile -t $(IMAGE):$(VERSION) prod
	docker build -f dev/Dockerfile -t $(IMAGE):$(VERSION)-dev dev

build-alpine:
	docker build -f Dockerfile -t $(IMAGE):alpine .


# Build and release
release: build
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)-dev

.PHONY: build release build-alpine
