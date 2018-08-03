ARG PHP_VERSION=7.0
FROM  previousnext/php:${PHP_VERSION}-base
LABEL maintainer="admin@previousnext.com.au"

# These get run on build.
ONBUILD COPY . /data
ONBUILD RUN chown -R www-data:www-data /data
