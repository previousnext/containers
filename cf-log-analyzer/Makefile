#!/usr/bin/make -f

IMAGE=previousnext/cf-log-analyzer
VERSION=latest

# Build and tests
build:
	docker build -t $(IMAGE):$(VERSION) .

lint:
	hadolint Dockerfile

# Build and release
release: build
	docker push $(IMAGE):$(VERSION)

.PHONY: build lint release
