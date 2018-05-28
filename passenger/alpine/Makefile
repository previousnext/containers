#!/usr/bin/make -f

IMAGE=previousnext/passenger
VERSION=alpine

build: build-prod build-dev

build-prod:
	docker build -f Dockerfile -t $(IMAGE):$(VERSION) .
	container-structure-test test --image $(IMAGE):$(VERSION) --config tests/passenger.yml

build-dev:
	docker build -f dev/Dockerfile -t $(IMAGE):$(VERSION)-dev dev
	container-structure-test test --image $(IMAGE):$(VERSION)-dev --config dev/tests/tools.yml

# Build and release
release: build
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):$(VERSION)-dev

.PHONY: build release
