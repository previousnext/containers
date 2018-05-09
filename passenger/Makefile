#!/usr/bin/make -f

IMAGE=previousnext/apache2
VERSION=latest

# Build and tests
build:
	docker build -f base/Dockerfile -t previousnext/passenger:base base
	docker build -f prod/Dockerfile -t previousnext/passenger:$(VERSION) prod
	docker build -f dev/Dockerfile -t previousnext/passenger:$(VERSION)-dev dev

# Build and release
release: build
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)-dev

.PHONY: build release