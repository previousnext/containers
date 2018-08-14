#!/usr/bin/make -f

IMAGE=previousnext/chrome-driver-headless
VERSION=latest

# Build and tests
build:
	docker build --build-arg CHROME_VERSION=68 -t $(IMAGE):68 -t $(IMAGE):$(VERSION) .
	docker build --build-arg CHROME_VERSION=67 -t $(IMAGE):67 .
	docker build --build-arg CHROME_VERSION=65 -t $(IMAGE):65 .

lint:
	hadolint Dockerfile

# Build and release
release: build
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):68
	docker push $(IMAGE):67
	docker push $(IMAGE):65

.PHONY: build lint release
