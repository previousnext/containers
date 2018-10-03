IMAGE=previousnext/frontend
PLATFORM=node
TIMESTAMP=$(shell date +%F)

# Build and tests
define build_test
	docker build \
		--build-arg NODE_VERSION=$(1) \
		-t $(IMAGE):$(PLATFORM)-$(1) \
		-t $(IMAGE):$(PLATFORM)-$(1)-$(TIMESTAMP)	.
	container-structure-test test --image $(IMAGE):$(PLATFORM)-$(1) --config tests/frontend.yml
endef

define push
	docker push $(IMAGE):$(PLATFORM)-$(1)
	docker push $(IMAGE):$(PLATFORM)-$(1)-$(TIMESTAMP)
endef

lint:
	hadolint Dockerfile

build:
	$(call build_test,8)

# Build and release
release: build
	$(call build_test,8)

.PHONY: build test lint release
