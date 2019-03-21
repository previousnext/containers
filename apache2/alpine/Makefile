#!/usr/bin/make -f

IMAGE=previousnext/apache2-alpine
VERSION=1.x
ALPINE_VERSION=3.9

# Allows for providing unique tags for images based on when they were built.
# Ideal for debugging!
TIMESTAMP=$(shell date +%F)

define push

endef

# Build all PHP versions
build:
	# Building and testing PROD...
	docker build --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
               -t ${IMAGE}:${VERSION} \
               -t ${IMAGE}:${TIMESTAMP} \
               --no-cache .
	# Building and testing DEV...
	docker build -f dev/Dockerfile \
	             --build-arg FROM=${IMAGE}:${VERSION} \
	             --build-arg ALPINE_VERSION=${ALPINE_VERSION} \
               -t ${IMAGE}:${VERSION}-dev \
               -t ${IMAGE}:${TIMESTAMP}-dev \
               --no-cache dev

lint:
	hadolint Dockerfile
	hadolint dev/Dockerfile
	

# Build and release
release: build
	# Pushing PROD...
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:${TIMESTAMP}
	# Pushing DEV...
	docker push ${IMAGE}:${VERSION}-dev
	docker push ${IMAGE}:${TIMESTAMP}-dev

.PHONY: build lint release
