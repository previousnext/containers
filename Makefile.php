#!/usr/bin/make -f

PHP_MINOR_VERSION=1

php: php-prepare php-build php-cleanup

php-build:
	# Building base container...
	cd php/7.x/base && $(DOCKER) -t previousnext/php:7.x-base .
	# Building production container...
	cd php/7.x/prod && $(DOCKER) -t previousnext/php:7.$(PHP_MINOR_VERSION)-apache .
	# Building development container...
	cd php/7.x/dev && $(DOCKER) -t previousnext/php:7.$(PHP_MINOR_VERSION)-dev .

php-prepare:
	# Generating a base Dockerfile...
	cp php/7.x/base/Dockerfile.tpl php/7.x/base/Dockerfile
	sed -i 's/PHP_MINOR_VERSION/$(PHP_MINOR_VERSION)/g' php/7.x/base/Dockerfile

php-push:
	# Pushing production container...
	docker push previousnext/php:7.$(PHP_MINOR_VERSION)-apache
	# Pushing development container...
	docker push previousnext/php:7.$(PHP_MINOR_VERSION)-dev

php-cleanup:
	# Cleaning up generated Dockerfile...
	rm php/7.x/base/Dockerfile

php-legacy:
	# Building base container...
	cd php/5.6/base && $(DOCKER) -t previousnext/php:5.6-base .
	# Building production container...
	cd php/5.6/prod && $(DOCKER) -t previousnext/php:5.6-apache .
	# Building development container...
	cd php/5.6/dev && $(DOCKER) -t previousnext/php:5.6-dev .

php-legacy-push:
	# Pushing production container...
	docker push previousnext/php:7.$(PHP_MINOR_VERSION)-apache
	# Pushing development container...
	docker push previousnext/php:7.$(PHP_MINOR_VERSION)-dev
