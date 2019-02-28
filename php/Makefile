#!/usr/bin/make -f

# RETIRED!!! Long live Alpine :)
# Please see the "apache" directory.

IMAGE=previousnext/php

define build_test
	docker build -f $(2)/base/Dockerfile --build-arg PHP_VERSION=$(1) -t $(IMAGE):$(1)-base $(2)/base
	docker build -f $(2)/prod/Dockerfile --build-arg PHP_VERSION=$(1) -t $(IMAGE):$(1)-apache $(2)/prod
	docker build -f $(2)/dev/Dockerfile --build-arg PHP_VERSION=$(1) -t $(IMAGE):$(1)-dev $(2)/dev
endef

define lint
	hadolint $(2)/base/Dockerfile
	hadolint $(2)/base/Dockerfile
	hadolint $(2)/base/Dockerfile
endef

define push
	docker push $(IMAGE):$(1)-apache
	docker push $(IMAGE):$(1)-dev
endef

# Build and tests
build: 5.6 7.1

# Build PHP 5.6
5.6:
	$(call build_test,5.6,5.6-apache-jessie)

# Build PHP 7.1
7.1:
	$(call build_test,7.1,7.x-apache-jessie)

lint:
	$(call lint,5.6,5.6-apache-jessie)
	$(call lint,7.1,7.x-apache-jessie)

# Build and release
release: build
	$(call push,5.6)
	$(call push,7.1)

.PHONY: build 5.6 7.1 lint release
