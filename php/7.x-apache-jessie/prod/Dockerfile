ARG PHP_VERSION=7.0
FROM       previousnext/php:${PHP_VERSION}-base
MAINTAINER nick_schuch

# These get run on build.
ONBUILD ADD . /data
ONBUILD RUN chown -R www-data:www-data /data
