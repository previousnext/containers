#!/usr/bin/make -f

IMAGE=previousnext/golang

define build_test
	docker build --build-arg GO_VERSION=$(1) -t $(IMAGE):$(1) .
	# @todo, Add tests.
endef

define push
	docker push $(IMAGE):$(1)
endef

# Build all Go
build: 1.11 1.12 1.13 1.14 1.15

1.11:
	$(call build_test,1.11)

1.12:
	$(call build_test,1.12)

1.13:
	$(call build_test,1.13)

1.14:
	$(call build_test,1.14)

1.15:
	$(call build_test,1.15)

lint:
	hadolint Dockerfile

# Build and release
release: build
	$(call push,1.11)
	$(call push,1.12)
	$(call push,1.13)
	$(call push,1.14)
	$(call push,1.15)

.PHONY: *
