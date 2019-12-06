#!/usr/bin/make -f

IMAGE=previousnext/node

define build
  docker build --build-arg NODE_VERSION=$(1) -t $(IMAGE):$(1) .
endef

define push
	docker push $(IMAGE):$(1)
endef

all: 8 10 12

lint:
	hadolint Dockerfile

8:
	$(call build,8)

10:
	$(call build,10)

12:
	$(call build,12)


release: all
	$(call push,8)
	$(call push,10)
	$(call push,12)

.PHONY: *
