#!/usr/bin/make -f

IMAGE=previousnext/php-apache
VERSION=3.x

define build_test
	# Building and testing PROD...
	docker build --build-arg ALPINE_VERSION=$(2) -t $(IMAGE):$(1)-$(VERSION) .
	structure-test test --image $(IMAGE):$(1)-$(VERSION) --config tests/$(subst .,-,$(1)).yml \
	                                                     --config tests/composer.yml \
	                                                     --config tests/drush.yml \
	                                                     --config tests/tuner.yml
	# Building and testing DEV...
	docker build --build-arg FROM=$(IMAGE):$(1)-$(VERSION) -t $(IMAGE):$(1)-$(VERSION)-dev dev
	structure-test test --image $(IMAGE):$(1)-$(VERSION)-dev --config dev/tests/frontend.yml \
	                                                         --config dev/tests/tools.yml
endef

define deploy
	# Pushing PROD...
	docker push $(IMAGE):$(1)-$(VERSION)
	# Pushing DEV...
	docker push $(IMAGE):$(1)-$(VERSION)-dev
endef

# Build PHP 7.1
7.1:
	$(call build_test,7.1,3.7)

# Build PHP 7.2
7.2:
	$(call build_test,7.2,edge)
	
# Build and release
release: 7.1 7.2
	$(call release,7.1)
	$(call release,7.2)
