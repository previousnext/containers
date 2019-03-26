#!/usr/bin/make -f

IMAGE=previousnext/node

define build
        docker build --build-arg NODE_VERSION=$(1) -t $(IMAGE):$(1) .
endef

all: 8 10

lint:
	hadolint Dockerfile

8:
	$(call build,8)

10:
	$(call build,10)

.PHONY: *
