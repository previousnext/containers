#!/usr/bin/make -f

IMAGE=previousnext/solr

define build_test
	docker build -f $(1)/Dockerfile -t $(IMAGE):$(1) $(1)
	# @todo, Add tests.
endef

define push
	docker push $(IMAGE):$(1)
endef

# Build and tests
build: 4.x 5.x

# Build Solr 4.x
4.x:
	$(call build_test,4.x)

# Build Solr 5.x
5.x:
	$(call build_test,5.x)

# Build and release
release: build
	$(call push,4.x)
	$(call push,5.x)

.PHONY: build 4.x 5.x release