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
build: 1.9 1.10 1.11 1.12 1.13

# Build Go 1.9
1.9:
	$(call build_test,1.9)

# Build Go 1.10
1.10:
	$(call build_test,1.10)

# Build Go 1.11
1.11:
	$(call build_test,1.11)

# Build Go 1.12
1.12:
	$(call build_test,1.12)

# Build Go 1.12
1.13:
	$(call build_test,1.13)

lint:
	hadolint Dockerfile

# Build and release
release: build
	$(call push,1.9)
	$(call push,1.10)
	$(call push,1.11)
	$(call push,1.12)
	$(call push,1.13)

.PHONY: build 1.9 1.10 1.11 1.12 lint release
