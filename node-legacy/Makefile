#!/usr/bin/make -f

IMAGE=skpr/node

define buildimage
  docker build --build-arg ALPINE_VERSION=$(1) --build-arg NODE_VERSION=$(2) -t $(IMAGE):$(2)-$(3) .
endef

define pushimage
	docker push $(IMAGE):$(1)-$(2)
endef

build: build10 build12 build14

lint:
	hadolint Dockerfile

build10:
	$(call buildimage,3.10,10,1.x)

build12:
	$(call buildimage,3.10,12,1.x)

build14:
	$(call buildimage,3.10,14,1.x)

push: build
	$(call pushimage,10,1.x)
	$(call pushimage,12,1.x)
	$(call pushimage,14,1.x)

.PHONY: *
