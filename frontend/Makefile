IMAGE=previousnext/frontend
VERSION=latest

# Build and tests
build:
	docker build -t $(IMAGE):$(VERSION) .

lint:
	hadolint Dockerfile

test:
	container-structure-test test --image $(IMAGE):$(VERSION) --config tests/frontend.yml

# Build and release
release: build
	docker push $(IMAGE):$(VERSION)

.PHONY: build test lint release
