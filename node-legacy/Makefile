#!/usr/bin/make -f

IMAGE=previousnext/node-legacy

define buildimage
  docker build --build-arg VERSION=$(1) -t $(IMAGE):$(1) .
endef

define pushimage
	docker push $(IMAGE):$(1)
endef

build: build10 build12 build14

lint:
	hadolint Dockerfile

build10:
	$(call buildimage,10-1.x)

build12:
	$(call buildimage,12-1.x)

build14:
	$(call buildimage,14-1.x)

push: build
	$(call pushimage,10-1.x)
	$(call pushimage,12-1.x)
	$(call pushimage,14-1.x)

.PHONY: *
