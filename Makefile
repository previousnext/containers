#!/usr/bin/make -f

DOCKER=docker build -f Dockerfile

# Builds all containers.
all: php solr apache2 oauth2 golang

# Builds all PHP prod and dev containers.
php: php-5.6 php-7.0 php-7.1 php-7.2

# Release new php images.
php-push: php-5.6-push php-7.0-push php-7.1-push php-7.2-push

php-5.6-push:
	docker push previousnext/php:5.6-apache
	docker push previousnext/php:5.6-dev

php-7.0-push:
	docker push previousnext/php:7.0-apache
	docker push previousnext/php:7.0-dev

php-7.1-push:
	docker push previousnext/php:7.1-apache
	docker push previousnext/php:7.1-dev

php-7.2-push:
	docker push previousnext/php:7.2-apache
	docker push previousnext/php:7.2-dev

# Builds all Solr containers.
solr: solr-4.x solr-5.x

# Release new solr images.
solr-push:
	docker push previousnext/solr:4.x
	docker push previousnext/solr:5.x

# Builds all Varnish containers.
varnish: varnish-4.x

# Builds Apache2 container.
apache2:
	cd apache2 && $(DOCKER) -t previousnext/apache2:latest .

# Release a new apache2 image.
apache2-push:
	docker push previousnext/apache2:latest

# Builds PHP 5.6 prod and dev containers.
php-5.6:
	cd php/5.6/base && $(DOCKER) -t previousnext/php:5.6-base .
	cd php/5.6/prod && $(DOCKER) -t previousnext/php:5.6-apache .
	cd php/5.6/dev && $(DOCKER) -t previousnext/php:5.6-dev .

# Builds PHP 7.0 prod and dev containers.
php-7.0:
	cd php/7.x/base && $(DOCKER) --build-arg PHP_VERSION=7.0 -t previousnext/php:7.0-base .
	cd php/7.x/prod && $(DOCKER) --build-arg PHP_VERSION=7.0 -t previousnext/php:7.0-apache .
	cd php/7.x/dev && $(DOCKER) --build-arg PHP_VERSION=7.0 -t previousnext/php:7.0-dev .

# Builds PHP 7.1 prod and dev containers.
php-7.1:
	cd php/7.x/base && $(DOCKER) --build-arg PHP_VERSION=7.1 -t previousnext/php:7.1-base .
	cd php/7.x/prod && $(DOCKER) --build-arg PHP_VERSION=7.1 -t previousnext/php:7.1-apache .
	cd php/7.x/dev && $(DOCKER) --build-arg PHP_VERSION=7.1 -t previousnext/php:7.1-dev .

# Builds PHP 7.2 prod and dev containers.
php-7.2:
	cd php/7.x/base && $(DOCKER) --build-arg PHP_VERSION=7.2 -t previousnext/php:7.2-base .
	cd php/7.x/prod && $(DOCKER) --build-arg PHP_VERSION=7.2 -t previousnext/php:7.2-apache .
	cd php/7.x/dev && $(DOCKER) --build-arg PHP_VERSION=7.2 -t previousnext/php:7.2-dev .

# Builds Passenger prod container.
passenger:
	cd passenger/base && $(DOCKER) -t previousnext/passenger:base .
	cd passenger/dev && $(DOCKER) -t previousnext/passenger:latest-dev .
	cd passenger/prod && $(DOCKER) -t previousnext/passenger:latest .

passenger-push:
	docker push previousnext/passenger:latest
	docker push previousnext/passenger:latest-dev

# Builds mkdocs container.
mkdocs:
	cd mkdocs && $(DOCKER) -t previousnext/mkdocs:latest .

# Builds ClamAV container.
clamav:
	cd clamav && $(DOCKER) -t previousnext/clamav:latest .

# Builds Solr containers.
solr-4.x:
	cd solr/4.x && $(DOCKER) -t previousnext/solr:4.x .

solr-5.x:
	cd solr/5.x && $(DOCKER) -t previousnext/solr:5.x .

varnish-4.x:
	cd varnish/4.x/dev && $(DOCKER) -t previousnext/varnish:4.x-dev .

# Builds Oauth Proxy container.
oauth2:
	cd oauth2_proxy/2.1 && $(DOCKER) -t previousnext/oauth2_proxy:2.1 .

# Release a new oauth2 image.
oauth2-push:
	docker push previousnext/oauth2_proxy:2.1

# Builds SFTP development container.
sftp:
	cd sftp/dev && $(DOCKER) -t previousnext/sftp:latest .

# Build & push go build container.
golang-push:
	cd golang && make GO_VERSION=1.8
	cd golang && make GO_VERSION=1.9

# Build & push go build container.
pnx-packager-push:
	cd pnx-packager && make build && make push

.PHONY: php php-push php-5.6 php-5.6-push php-7.0 php-7.0-push php-7.1 php-7.1-push php-7.2 php-7.2-push solr-4.x solr-5.x apache2 oauth2 mkdocs passenger clamav mkdocs varnish-4.x sftp golang-push pnx-packager-push
