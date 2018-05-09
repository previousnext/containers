#!/usr/bin/make -f

# RETIRED!!! Long live Alpine :)
# Please see the "apache" directory.

IMAGE=previousnext/php

define build_test
	docker build -f 7.x-apache-$(2)/base --build-arg PHP_VERSION=$(1) -t $(IMAGE):$(1)-base .
	docker build -f 7.x-apache-$(2)/prod --build-arg PHP_VERSION=$(1) -t $(IMAGE):$(1)-apache .
	docker build -f 7.x-apache-$(2)/dev --build-arg PHP_VERSION=$(1) -t $(IMAGE):$(1)-dev .
endef

define push
	docker push $(IMAGE):$(1)
	docker push $(IMAGE):$(1)-dev
endef

# Build and tests
build: 7.1 7.2

# Build PHP 7.1
7.1:
	$(call build_test,7.1,jessie)

# Build PHP 7.2
7.2:
	$(call build_test,7.2,stretch)

# Build and release
release: build
	$(call push,7.1)
	$(call push,7.2)

.PHONY: build 4.x 5.x release