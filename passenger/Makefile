#!/usr/bin/make -f

IMAGE=previousnext/passenger
VERSION=latest

# Build and tests
build:
	docker build -f base/Dockerfile -t $(IMAGE):base base
	docker build -f prod/Dockerfile -t $(IMAGE):$(VERSION) prod
	docker build -f dev/Dockerfile -t $(IMAGE):$(VERSION)-dev dev

build-alpine:
	docker build -f alpine/Dockerfile -t $(IMAGE):alpine alpine
	container-structure-test test --image $(IMAGE):alpine --config alpine/tests/passenger.yml
	docker build -f alpine/dev/Dockerfile -t $(IMAGE):alpine-dev alpine/dev
	container-structure-test test --image $(IMAGE):alpine-dev --config alpine/dev/tests/tools.yml

# Build and release
release: build
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)-dev

.PHONY: build release build-alpine
