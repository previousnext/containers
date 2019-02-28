#!/usr/bin/make -f

IMAGE=previousnext/php-apache
VERSION=3.x

# Allows for providing unique tags for images based on when they were built.
# Ideal for debugging!
TIMESTAMP=$(shell date +%F)

define build_test
	# Building and testing PROD...
	docker build --build-arg ALPINE_VERSION=$(2) \
	             --build-arg PHP_VERSION=$(1) \
                     -t $(IMAGE):$(1)-$(VERSION) \
                     -t $(IMAGE):$(1)-$(TIMESTAMP) \
                     --no-cache .
	container-structure-test test --image $(IMAGE):$(1)-$(VERSION) \
	                              --config tests/$(subst .,-,$(1)).yml \
	                              --config tests/bash.yml \
                                      --config tests/composer.yml \
	                              --config tests/drush.yml \
	                              --config tests/tuner.yml
	# Building and testing DEV...
	docker build -f dev/Dockerfile \
	             --build-arg FROM=$(IMAGE):$(1)-$(VERSION) \
	             --build-arg ALPINE_VERSION=$(2) \
                     --build-arg PHP_VERSION=$(1) \
                     -t $(IMAGE):$(1)-$(VERSION)-dev \
                     -t $(IMAGE):$(1)-$(TIMESTAMP)-dev \
                     --no-cache dev
	container-structure-test test --image $(IMAGE):$(1)-$(VERSION)-dev \
	                              --config dev/tests/frontend.yml \
                                      --config dev/tests/php.yml \
                                      --config dev/tests/alpine$(2).yml \
	                              --config dev/tests/tools.yml
endef

define push
	# Pushing PROD...
	docker push $(IMAGE):$(1)-$(VERSION)
	docker push $(IMAGE):$(1)-$(TIMESTAMP)
	# Pushing DEV...
	docker push $(IMAGE):$(1)-$(VERSION)-dev
	docker push $(IMAGE):$(1)-$(TIMESTAMP)-dev
endef

# Build all PHP versions
build: 7.1 7.2 7.3

# Build PHP 7.1
7.1:
	$(call build_test,7.1,3.8)

# Build PHP 7.2
7.2:
	$(call build_test,7.2,3.8)

# Build PHP 7.3
7.3:
	$(call build_test,7.3,3.9)

lint:
	hadolint Dockerfile

# Build and release
release: build
	$(call push,7.1)
	$(call push,7.2)
	$(call push,7.3)

.PHONY: build 7.1 7.2 lint release
