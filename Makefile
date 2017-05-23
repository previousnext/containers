#!/usr/bin/make -f

DOCKER=docker build -f Dockerfile

# Builds all containers.
all: php solr apache2 oauth2

# Builds all PHP prod and dev containers.
php: php-5.6 php-7.0 php-7.1 php-7.x

# Builds all Solr containers.
solr: solr-4.x solr-5.x

# Builds Apache2 container.
apache2:
	cd apache2 && $(DOCKER) -t previousnext/apache2:latest .

# Builds PHP 5.6 prod and dev containers.
php-5.6:
	cd php/5.6 && $(DOCKER) -t previousnext/php:5.6 .
	cd php/5.6-dev && $(DOCKER) -t previousnext/php:5.6-dev .

# Builds PHP 7.0 prod and dev containers.
php-7.0:
	cd php/7.0 && $(DOCKER) -t previousnext/php:7.0 .
	cd php/7.0-dev && $(DOCKER) -t previousnext/php:7.0-dev .

# Builds PHP 7.1 prod and dev containers.
php-7.1:
	cd php/7.1 && $(DOCKER) -t previousnext/php:7.1 .
	cd php/7.1-dev && $(DOCKER) -t previousnext/php:7.1-dev .

# Builds PHP 7.x prod and dev containers.
php-7.x:
	cd php/7.x && $(DOCKER) -t previousnext/php:7.x .
	cd php/7.x-dev && $(DOCKER) -t previousnext/php:7.x-dev .

# Builds Passenger prod container.
passenger:
	cd passenger && $(DOCKER) -t previousnext/passenger:latest .

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

# Builds Oauth Proxy container.
oauth2:
	cd oauth2_proxy/2.1 && $(DOCKER) -t previousntxt/oauth2_proxy:2.1 .

.PHONY: php-5.6 php-7.0 php-7.1 php-7.x solr-4.x solr-5.x passenger clamav mkdocs
