#!/usr/bin/make -f

IMAGE=previousnext/oauth2_proxy
VERSION=2.1

# Build and tests
build:
	docker build -t $(IMAGE):$(VERSION) .

# Build and release
release: build
	docker push $(IMAGE):$(VERSION)

.PHONY: build release