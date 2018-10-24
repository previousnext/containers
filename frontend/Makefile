IMAGE=previousnext/frontend
VERSION=latest

# Build and tests
build:
	docker build -t $(IMAGE):$(VERSION) .
	container-structure-test test --image $(IMAGE):$(VERSION) --config tests/frontend.yml

lint:
	hadolint Dockerfile	

# Build and release
release: build
	docker push $(IMAGE):$(VERSION)

.PHONY: build test lint release
