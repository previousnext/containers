#!/usr/bin/make -f

DOCKER=docker build -f Dockerfile

include Makefile.php

# Builds all containers.
all: solr apache2 oauth2 golang

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
	cd golang && make build && make push

# Build & push go build container.
pnx-packager-push:
	cd pnx-packager && make build && make push

.PHONY: solr-4.x solr-5.x apache2 oauth2 mkdocs passenger clamav mkdocs varnish-4.x sftp golang-push pnx-packager-push
